import UIKit
import SVProgressHUD

class TasksViewController: UIViewController {

    // MARK: IBOutlets

    @IBOutlet private weak var textFieldAddTask: UITextField! {
        didSet {
            textFieldAddTask.delegate = self
        }
    }

    @IBOutlet private weak var viewAddBox: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var tableViewTopConstraint: NSLayoutConstraint!

    // MARK: Properties
    
    var presenter: TasksPresenter?
    private var tasks: [Task]?
    private var barButtonAdd: UIBarButtonItem?
    private var barButtonCancel: UIBarButtonItem?
    
    // MARK: Initialization
    
    init() {
        super.init(nibName: "TasksViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupNavigationBar()

        presenter?.viewDidLoad()
        presenter?.fetchTasks()
    }

    // MARK: Private API

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "TaskCell")
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        barButtonAdd = UIBarButtonItem(image: #imageLiteral(resourceName: "add"), style: .done, target: self, action: #selector(toggleAddBox))
        barButtonCancel = UIBarButtonItem(image: #imageLiteral(resourceName: "cancel"), style: .done, target: self, action: #selector(toggleAddBox))
        navigationItem.rightBarButtonItem = barButtonAdd
    }

    private func hideAddBox(_ hide: Bool) {
        tableViewTopConstraint.constant = hide ? 0 : 80

        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.viewAddBox.alpha = hide ? 0.0 : 1.0
            self?.viewAddBox.isHidden = hide
            self?.navigationItem.rightBarButtonItem = hide ? self?.barButtonAdd : self?.barButtonCancel
            self?.view.layoutIfNeeded()
        }

        _ = hide ? textFieldAddTask.resignFirstResponder() : textFieldAddTask.becomeFirstResponder()
    }

    @objc private func toggleAddBox() {
        hideAddBox(!viewAddBox.isHidden)
    }

    // MARK: ScrollViewDelegate

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if !viewAddBox.isHidden {
            hideAddBox(true)
        }
    }
}

// MARK: TasksView

extension TasksViewController: TasksView {
    func showSpinner() {
        SVProgressHUD.show()
    }

    func dismissSpinner() {
        SVProgressHUD.dismiss()
    }

    func refreshTasksList() {
        textFieldAddTask.resignFirstResponder()
        textFieldAddTask.text = ""
        hideAddBox(true)

        presenter?.fetchTasks()
    }

    func showTasks(_ tasks: [Task]?) {
        self.tasks = tasks
        tableView.reloadData()
    }

    func showError(_ error: String) {
        self.present(UIAlertController.errorAlert(message: error), animated: true, completion: nil)
    }

    func setNavigationTitle(_ text: String) {
        self.title = text
    }
}

// MARK: UITableViewDelegate

extension TasksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { [weak self] action, indexPath in
            guard let task = self?.tasks?[indexPath.row] else { return }

            self?.presenter?.routeToEdit(with: task)
        }

        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { [weak self] action, indexPath in
            guard let task = self?.tasks?[indexPath.row] else { return }

            self?.tasks?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)

            self?.presenter?.deleteTask(task: task)
        }

        editAction.backgroundColor = .orange
        deleteAction.backgroundColor = .red

        return [editAction, deleteAction]
    }
}

// MARK: UITableViewDataSource

extension TasksViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskCell {
            guard let task = tasks?[indexPath.row] else { return UITableViewCell() }

            cell.setup(task: task, delegate: self)

            return cell
        }

        return UITableViewCell()
    }

}

// MARK: UITextFieldDelegate

extension TasksViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        presenter?.createTask(name: textField.text)

        return true
    }
}

// MARK: TaskCellDelegate

extension TasksViewController: TaskCellDelegate {
    func didTouchDone(cell: UITableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            if let task = tasks?[indexPath.row], let cell = cell as? TaskCell {
                cell.updateState(!task.done)
                tasks?[indexPath.row].done = !task.done

                presenter?.updateTask(id: task.id, done: !task.done)
            }
        }
    }
}
