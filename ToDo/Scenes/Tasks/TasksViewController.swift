import UIKit

class TasksViewController: UIViewController {
    
    @IBOutlet private weak var textFieldAddTask: UITextField!
    @IBOutlet private weak var viewAddBox: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var tableViewTopConstraint: NSLayoutConstraint!

    // MARK: Properties
    
    var presenter: TasksPresenter?
    private var tasks: [Task]?
    
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

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "TaskCell")
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true

        let barButton = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(toggleAddBox))
        barButton.tintColor = .black
        navigationItem.rightBarButtonItem = barButton
    }

    private func hideAddBox(_ hide: Bool) {
        tableViewTopConstraint.constant = hide ? 0 : 80

        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.viewAddBox.alpha = hide ? 0.0 : 1.0
            self?.viewAddBox.isHidden = hide
            self?.view.layoutIfNeeded()
        }

        _ = hide ? textFieldAddTask.resignFirstResponder() : textFieldAddTask.becomeFirstResponder()
    }

    @objc private func toggleAddBox() {
        hideAddBox(!viewAddBox.isHidden)
    }

}

extension TasksViewController: TasksView {
    func showTasks(_ tasks: [Task]?) {
        self.tasks = tasks
        tableView.reloadData()
    }

    func showError(_ error: String) {
        print(error)
    }

    func setNavigationTitle(_ text: String) {
        self.title = text
    }
}

extension TasksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { [weak self] action, indexPath in
            guard let todo = self?.tasks?[indexPath.row] else { return }

        }

        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { [weak self] action, indexPath in
            guard let todo = self?.tasks?[indexPath.row] else { return }

            self?.tasks?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)

        }

        editAction.backgroundColor = .orange
        deleteAction.backgroundColor = .red

        return [editAction, deleteAction]
    }
}

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

extension TasksViewController: TaskCellDelegate {
    func didTouchDone(cell: UITableViewCell) {
        
    }
}
