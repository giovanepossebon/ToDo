import UIKit

protocol TasksView: class {
    func showTasks(_ tasks: [Task]?)
    func showError(_ error: String)
    func setNavigationTitle(_ text: String)
    func showSpinner()
    func hideSpinner()
    func refreshTasksList()
}

protocol TasksViewPresenter {
    func fetchTasks()
    func createTask(name: String?)
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

    func createTask(name: String?) {
        guard let name = name, !name.isEmpty else { return }

        let input = TaskInput(name: name, done: false)

        view.showSpinner()
        service.createTask(todoId: viewModel.todoId, input: input) { [weak self] _, error in
            self?.view.hideSpinner()

            guard error == nil else {
                self?.view.showError(error?.message ?? "")
                return
            }

            self?.view.refreshTasksList()
        }
    }

    func deleteTask(task: Task) {
        view.showSpinner()
        service.deleteTask(todoId: task.todoId, itemId: task.id) { [weak self] success, error in
            self?.view.hideSpinner()
            if !success {
                self?.view.showError(error?.message ?? "")
                self?.view.refreshTasksList()
            }
        }
    }
}
