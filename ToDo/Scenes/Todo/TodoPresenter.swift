import UIKit

protocol TodoView: class {
    func setTodoList(_ todos: [Todo]?)
    func showError(_ error: String)
    func showSpinner()
    func dismissSpinner()
    func refreshTodoList()
}

protocol TodoViewPresenter: class {
    func fetchTodoList()
    func createTodo(title: String?)
    func showTodoList(todo: Todo)
    func editTodoList(todo: Todo) 
}

class TodoPresenter: TodoViewPresenter {
    
    // MARK: Properties
    
    unowned let view: TodoView
    private let service: TodoServiceContract
    private let router: TodoViewRouter
    
    // MARK: Initialization
    
    init(view: TodoView, service: TodoServiceContract, router: TodoViewRouter) {
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
        router.toTodoEdit(id: todo.id)
    }

}
