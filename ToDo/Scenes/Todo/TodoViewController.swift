import UIKit

class TodoViewController: UIViewController, NavigationBarManager {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var buttonAddList: UIButton!

    // MARK: Properties
    
    var presenter: TodoPresenter?

    private var todos: [Todo]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: Initialization
    
    init() {
        super.init(nibName: "TodoViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupNavigationBarWithoutTitle()
        presenter?.fetchTodoList()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 164.0
        tableView.register(UINib(nibName: "TodoCell", bundle: nil), forCellReuseIdentifier: "TodoCell")
    }

    @IBAction func didTouchAddList(_ sender: Any) {
        
    }
}

extension TodoViewController: TodoView {
    func showError(_ error: String) {
        print(error)
    }

    func setTodoList(_ todos: [Todo]?) {
        self.todos = todos
    }
}

extension TodoViewController: UITableViewDelegate {

}

extension TodoViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as? TodoCell {
            guard let todo = todos?[indexPath.row] else { return UITableViewCell() }

            cell.setup(title: todo.title, delegate: self)
            return cell
        }

        return UITableViewCell()
    }
}

extension TodoViewController: TodoCellDelegate {
    func didTouchEdit(cell: TodoCell) {
        let indexPath = tableView.indexPath(for: cell)
        print(indexPath)
    }

    func didTouchDelete(cell: TodoCell) {
        let indexPath = tableView.indexPath(for: cell)
        print(indexPath)
    }
}
