import Quick
import Nimble

@testable import ToDo

class LoginTests: QuickSpec {
    
    override func spec() {
 
        var view: LoginViewSpy!
        var router: LoginViewRouterSpy!
        var presenter: LoginPresenter!
        var service: LoginServiceMock!
        
        describe("LoginPresenter") {
            
            beforeEach {
                view = LoginViewSpy()
                router = LoginViewRouterSpy()
                service = LoginServiceMock()
                presenter = LoginPresenter(view: view, router: router, service: service)
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

                    context("and the service return a success") {
                        it("should call login normally") {
                            presenter.login(email: "test@test.com", password: "123456")
                            expect(view.spinnerCalled).to(beTrue())
                            expect(view.spinnerDismissed).to(beTrue())
                            expect(router.loginCalled).to(beTrue())
                            expect(view.error).to(beNil())
                            expect(view.spinnerDismissed).to(beTrue())
                        }
                    }

                    context("and the service returns a failure") {
                        it("should show a proper error message") {
                            presenter.login(email: "test@test.com", password: "1234")
                            expect(view.spinnerCalled).to(beTrue())
                            expect(router.loginCalled).to(beFalse())
                            expect(view.error) == "Invalid credentials"
                            expect(view.spinnerDismissed).to(beTrue())
                        }
                    }

                }
            }

            describe("when user tap on sign up") {

                it("should present the sign up view") {
                    presenter.signUp()
                    expect(router.presentSignUpCalled).to(beTrue())
                }

            }
        }
    }
}

private class LoginViewSpy: LoginView {
    var error: String?
    var spinnerCalled: Bool = false
    var spinnerDismissed: Bool = false

    func showError(_ error: String) {
        self.error = error
    }

    func showSpinner() {
        spinnerCalled = true
    }

    func dismissSpinner() {
        spinnerDismissed = true
    }
}

private class LoginViewRouterSpy: LoginViewRouter {
    var presentSignUpCalled: Bool = false
    var loginCalled: Bool = false

    func presentSignUp() {
        presentSignUpCalled = true
    }

    func login() {
        loginCalled = true
    }
}

private class LoginServiceMock: LoginServiceContract {
    func login(input: LoginInput, callback: @escaping ((LoginOutput?, APIError?) -> Void)) {
        if input.password == "123456" {
            callback(LoginOutput(authToken: "123456"), nil)
        } else {
            callback(LoginOutput(authToken: ""), APIError(message: "Invalid credentials"))
        }
    }
}
