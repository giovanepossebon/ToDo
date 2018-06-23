import Quick
import Nimble

@testable import ToDo

class TasksTests: QuickSpec {
    
    override func spec() {
 
        var view: TasksViewSpy!
        
        describe("TasksPresenter") {
            
            beforeEach {
                view = TasksViewSpy()
            }

        }
    }
}

private class TasksViewSpy: TasksView {
    var tasks: [Task]?
    var error: String?
    var navigationTitle: String?

    func showTasks(_ tasks: [Task]?) {
        self.tasks = tasks
    }

    func showError(_ error: String) {
        self.error = error
    }

    func setNavigationTitle(_ text: String) {
        navigationTitle = text
    }
}

