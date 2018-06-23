import UIKit
import SVProgressHUD

class TodoViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var tableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var textFieldNewTodo: UITextField! {
        didSet {
            textFieldNewTodo.delegate = self
        }
    }
    @IBOutlet weak var viewAddBox: UIView!
    
    // MARK: Properties
    
    var presenter: TodoPresenter?
    private var todos: [Todo]?
    private var barButtonAdd: UIBarButtonItem?
    private var barButtonCancel: UIBarButtonItem?
    
    // MARK: Initialization
    
    init() {
        super.init(nibName: "TodoViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupNavigationBar()
        presenter?.fetchTodoList()
    }

    private func setupNavigationBar() {
        self.title = "To Do Lists"
        navigationController?.navigationBar.prefersLargeTitles = true

        barButtonAdd = UIBarButtonItem(image: #imageLiteral(resourceName: "add"), style: .done, target: self, action: #selector(toggleAddBox))
        barButtonCancel = UIBarButtonItem(image: #imageLiteral(resourceName: "cancel"), style: .done, target: self, action: #selector(toggleAddBox))
        navigationItem.rightBarButtonItem = barButtonAdd
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 164.0
        tableView.register(UINib(nibName: "TodoCell", bundle: nil), forCellReuseIdentifier: "TodoCell")
    }

    private func hideAddBox(_ hide: Bool) {
        tableViewTopConstraint.constant = hide ? 0 : 80

        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.viewAddBox.alpha = hide ? 0.0 : 1.0
            self?.viewAddBox.isHidden = hide
            self?.navigationItem.rightBarButtonItem = hide ? self?.barButtonAdd : self?.barButtonCancel
            self?.view.layoutIfNeeded()
        }

        _ = hide ? textFieldNewTodo.resignFirstResponder() : textFieldNewTodo.becomeFirstResponder()
    }

    @objc private func toggleAddBox() {
        hideAddBox(!viewAddBox.isHidden)
    }
}

extension TodoViewController: TodoView {
    func showError(_ error: String) {
        print(error)
    }

    func setTodoList(_ todos: [Todo]?) {
        self.todos = todos
        tableView.reloadData()
    }

    func refreshTodoList() {
        textFieldNewTodo.resignFirstResponder()
        textFieldNewTodo.text = ""
        toggleAddBox()

        presenter?.fetchTodoList()
    }

    func showSpinner() {
        SVProgressHUD.show()
    }

    func dismissSpinner() {
        SVProgressHUD.dismiss()
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if !viewAddBox.isHidden {
            hideAddBox(true)
        }
    }
}

extension TodoViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let todo = todos?[indexPath.row] {
            presenter?.showTodoList(todo: todo)
        }
    }

}

extension TodoViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as? TodoCell {
            guard let todo = todos?[indexPath.row] else { return UITableViewCell() }

            cell.setup(title: todo.title)
            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { [weak self] action, indexPath in
            guard let todo = self?.todos?[indexPath.row] else { return }

            self?.presenter?.editTodoList(todo: todo)
        }

        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { [weak self] action, indexPath in
            guard let todo = self?.todos?[indexPath.row] else { return }

            self?.todos?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)

            self?.presenter?.deleteTodo(todo)
        }

        editAction.backgroundColor = .orange
        deleteAction.backgroundColor = .red

        return [editAction, deleteAction]
    }
}

extension TodoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        presenter?.createTodo(title: textField.text)

        return true
    }
}
