import UIKit

protocol TasksView: class {
    func showTasks(_ tasks: [Task]?)
    func showError(_ error: String)
    func setNavigationTitle(_ text: String)
}

protocol TasksViewPresenter {
    func fetchTasks()
    func viewDidLoad()
}

class TasksPresenter: TasksViewPresenter {

    // MARK: Properties

    unowned let view: TasksView
    private let viewModel: ViewModel
    private let service: TaskServiceContract

    // MARK: Initialization
    
    init(view: TasksView, service: TaskServiceContract, viewModel: ViewModel) {
        self.view = view
        self.service = service
        self.viewModel = viewModel
    }
    
    // MARK: Public API

    func viewDidLoad() {
        view.setNavigationTitle(viewModel.title)
    }

    func fetchTasks() {
        service.fetchTasks(todoId: viewModel.todoId) { [weak self] output, error in
            guard error == nil else {
                self?.view.showError(error?.message ?? "")
                return
            }

            let tasks = output?.compactMap { Task(output: $0) }
            self?.view.showTasks(tasks)
        }
    }
}
