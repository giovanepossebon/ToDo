import UIKit

class TasksViewController: UIViewController {
    
    @IBOutlet private weak var textFieldAddTask: UITextField!
    @IBOutlet private weak var viewAddBox: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var tableVIewTopConstraint: NSLayoutConstraint!

    // MARK: Properties
    
    var presenter: TasksPresenter?
    
    // MARK: Initialization
    
    init() {
        super.init(nibName: "TasksViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension TasksViewController: TasksView {

}
