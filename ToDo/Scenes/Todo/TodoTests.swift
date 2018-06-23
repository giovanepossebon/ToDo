import Quick
import Nimble

@testable import ToDo

// swiftlint:disable function_body_length
class TodoTests: QuickSpec {
    
    override func spec() {
 
        var view: TodoViewSpy!
        
        describe("TodoPresenter") {
            
            beforeEach {
                view = TodoViewSpy()
            }
            
        }
    }
}

private class TodoViewSpy: TodoView {}

