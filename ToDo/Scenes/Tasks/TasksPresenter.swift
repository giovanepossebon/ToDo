import UIKit

protocol TasksView: class {
    // View methods
}

protocol TasksViewPresenter {
    func fetchTasks()
}

class TasksPresenter: TasksViewPresenter {

    // MARK: Properties

    unowned let view: TasksView
    private let viewModel: ViewModel

    // MARK: Initialization
    
    init(view: TasksView, viewModel: ViewModel) {
        self.view = view
        self.viewModel = viewModel
    }
    
    // MARK: Public API

    func fetchTasks() {
        
    }
}
