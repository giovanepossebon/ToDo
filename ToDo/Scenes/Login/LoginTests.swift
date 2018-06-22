import Quick
import Nimble

@testable import ToDo

class LoginTests: QuickSpec {
    
    override func spec() {
 
        var view: LoginViewSpy!
        var presenter: LoginPresenter!
        
        describe("LoginPresenter") {
            
            beforeEach {
                view = LoginViewSpy()
                presenter = LoginPresenter(view: view)
            }
            
            describe("when user tries to login") {

                context("and didn't filled the email text field") {
                    it("should show a proper error message") {
                        presenter.login(email: "", password: "123456")
                        expect(view.error) == "Invalid email"
                    }
                }

                context("and didn't filled the password text field") {
                    it("should show a proper error message") {
                        presenter.login(email: "test@test.com", password: "")
                        expect(view.error) == "Invalid password"
                    }
                }

                context("and filled the email and the password properly") {
                    it("should call login normally") {
                        presenter.login(email: "test@test.com", password: "123456")
                        expect(view.error).to(beNil())
                    }
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
