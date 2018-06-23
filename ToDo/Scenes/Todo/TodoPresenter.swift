import UIKit

protocol TodoView: class {
    func setTodoList(_ todos: [Todo]?)
    func showError(_ error: String)
}

protocol TodoViewPresenter: class {
    func fetchTodoList()
}

class TodoPresenter: TodoViewPresenter {
    
    // MARK: Properties
    
    unowned let view: TodoView
    private let service: TodoServiceContract
    
    // MARK: Initialization
    
    init(view: TodoView, service: TodoServiceContract) {
        self.view = view
        self.service = service
    }
    
    // MARK: Public API

    func fetchTodoList() {
        service.fetchTodos { [weak self] response in
            switch response.result {
            case .success:
                let todos = response.data?.compactMap { Todo(output: $0) }
                self?.view.setTodoList(todos)
            case .error(message: let error):
                self?.view.showError(error)
            }
        }
    }

}
