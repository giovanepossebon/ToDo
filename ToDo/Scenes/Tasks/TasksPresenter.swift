import UIKit

protocol TasksView: class {
    func showTasks(_ tasks: [Task]?)
    func showError(_ error: String)
    func setNavigationTitle(_ text: String)
    func showSpinner()
    func dismissSpinner()
    func refreshTasksList()
}

protocol TasksViewPresenter {
    func fetchTasks()
    func createTask(name: String?)
    func viewDidLoad()
    func editTask(id: Int, newValue: String)
    func routeToEdit(with task: Task)
    func updateTask(id: Int, done: Bool)
}

class TasksPresenter: TasksViewPresenter {

    // MARK: Properties

    unowned let view: TasksView
    private let viewModel: ViewModel
    private let service: TaskServiceContract
    private let router: TasksViewRouter

    // MARK: Initialization
    
    init(view: TasksView, service: TaskServiceContract, viewModel: ViewModel, router: TasksViewRouter) {
        self.view = view
        self.service = service
        self.viewModel = viewModel
        self.router = router
    }
    
    // MARK: Public API

    func viewDidLoad() {
        view.setNavigationTitle(viewModel.title)
    }

    func fetchTasks() {
        view.showSpinner()
        service.fetchTasks(todoId: viewModel.todoId) { [weak self] output, error in
            self?.view.dismissSpinner()
            guard error == nil else {
                self?.view.showError(error?.message ?? "")
                return
            }

            let tasks = output?.compactMap { Task(output: $0) }
                .sorted(by: {
                    $0.created.compare($1.created) == .orderedDescending
                })

            self?.view.showTasks(tasks)
        }
    }

    func createTask(name: String?) {
        guard let name = name, !name.isEmpty else { return }

        let input = TaskInput(name: name, done: false)

        view.showSpinner()
        service.createTask(todoId: viewModel.todoId, input: input) { [weak self] _, error in
            self?.view.dismissSpinner()

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
            self?.view.dismissSpinner()
            if !success {
                self?.view.showError(error?.message ?? "")
                self?.view.refreshTasksList()
            }
        }
    }

    func routeToEdit(with task: Task) {
        router.routeToEdit(task: task)
    }

    func editTask(id: Int, newValue: String) {
        let input = TaskInput(name: newValue)

        view.showSpinner()
        service.editTask(todoId: viewModel.todoId, itemId: id, input: input) { [weak self] success, error in
            self?.view.dismissSpinner()

            if !success {
                self?.view.showError(error?.message ?? "")
            }

            self?.view.refreshTasksList()
        }
    }

    func updateTask(id: Int, done: Bool) {
        let input = TaskInput(done: done)

        service.editTask(todoId: viewModel.todoId, itemId: id, input: input) { [weak self] success, error in
            if !success {
                self?.view.showError(error?.message ?? "")
                self?.view.refreshTasksList()
            }
        }
    }

}

extension TasksPresenter: EditPopupDelegate {
    func editPopupDidConfirm(_ viewController: UIViewController, newValue: String, for id: Int) {
        viewController.dismiss(animated: true) { [weak self] in
            self?.editTask(id: id, newValue: newValue)
        }
    }

    func editPopupDidDismiss(_ viewController: UIViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}
