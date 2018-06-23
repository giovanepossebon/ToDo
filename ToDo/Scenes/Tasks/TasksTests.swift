import Quick
import Nimble

@testable import ToDo

// swiftlint:disable function_body_length
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

private class TasksViewSpy: TasksView {}

