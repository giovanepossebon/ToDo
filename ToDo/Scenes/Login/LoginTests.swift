import Quick
import Nimble

@testable import ToDo

class LoginTests: QuickSpec {
    
    override func spec() {
 
        var view: LoginViewSpy!
        var presenter: LoginViewPresenterSpy!
        
        describe("LoginPresenter") {
            
            beforeEach {
                view = LoginViewSpy()
                presenter = LoginViewPresenterSpy(view: view)
            }
            
            describe("when the view is attached") {

                it("should init the view") {
                    expect(presenter.initialized).to(beTrue())
                }

            }
        }
    }
}

private class LoginViewSpy: LoginView {
    var error: String?

    func showError(_ error: String) {
        self.error = error
    }

}

private class LoginViewPresenterSpy: LoginViewPresenter {
    var initialized: Bool = false
    var loginCalled: Bool = false

    required init(view: LoginView) {
        initialized = true
    }

    func login(email: String, password: String) {
        loginCalled = true
    }
}
