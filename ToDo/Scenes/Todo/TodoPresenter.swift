import UIKit

protocol TodoView: class {
    func setTodoList(_ todos: [Todo]?)
    func showError(_ error: String)
    func showSpinner()
    func dismissSpinner()
    func refreshTodoList()
}

protocol TodoViewPresenter {
    init(view: TodoView, service: TodoServiceContract, router: TodoViewRouter)
    func fetchTodoList()
    func createTodo(title: String?)
    func showTodoList(todo: Todo)
    func editTodoList(todo: Todo)
}

class TodoPresenter: TodoViewPresenter {
    
    // MARK: Properties
    
    unowned let view: TodoView
    internal let service: TodoServiceContract
    internal let router: TodoViewRouter
    
    // MARK: Initialization
    
    required init(view: TodoView, service: TodoServiceContract, router: TodoViewRouter) {
        self.view = view
        self.service = service
        self.router = router
    }
    
    // MARK: Public API

    func fetchTodoList() {
        view.showSpinner()
        service.fetchTodos { [weak self] output, error in
            self?.view.dismissSpinner()
            guard error == nil else {
                self?.view.showError(error?.localizedDescription ?? "")
                return
            }

            let todos = output?.compactMap { Todo(output: $0) }
                .sorted(by: {
                    $0.created.compare($1.created) == .orderedDescending
                })

            self?.view.setTodoList(todos)
        }
    }

    func createTodo(title: String?) {
        guard let title = title, !title.isEmpty else { return }

        let input = TodoInput(title: title)

        view.showSpinner()
        service.createTodo(input: input) { [weak self] _, error in
            self?.view.dismissSpinner()
            guard error == nil else {
                self?.view.showError(error?.localizedDescription ?? "")
                return
            }

            self?.view.refreshTodoList()
        }
    }

    func deleteTodo(_ todo: Todo) {
        view.showSpinner()
        service.deleteTodo(id: todo.id) { [weak self] success, error in
            self?.view.dismissSpinner()
            if !success {
                self?.view.showError(error?.message ?? "")
                self?.view.refreshTodoList()
            }
        }
    }

    func showTodoList(todo: Todo) {
        router.toTodoList(id: todo.id, title: todo.title)
    }

    func editTodoList(todo: Todo) {
        router.toTodoEdit(id: todo.id, title: todo.title)
    }

    func editTodo(with id: Int, newTitle: String) {
        let input = TodoInput(title: newTitle)

        view.showSpinner()
        service.editTodo(id: id, input: input) { [weak self] success, error in
            self?.view.dismissSpinner()
            if !success {
                self?.view.showError(error?.message ?? "")
                return
            }

            self?.view.refreshTodoList()
        }
    }

}

extension TodoPresenter: EditPopupDelegate {
    func editPopupDidConfirm(_ viewController: UIViewController, newValue: String, for id: Int) {
        viewController.dismiss(animated: true) { [weak self] in
            self?.editTodo(with: id, newTitle: newValue)
        }
    }

    func editPopupDidDismiss(_ viewController: UIViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}
