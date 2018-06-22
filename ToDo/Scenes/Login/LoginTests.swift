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
                            expect(router.loginCalled).to(beTrue())
                            expect(view.error).to(beNil())
                        }
                    }

                    context("and the service returns a failure") {
                        it("should show a proper error message") {
                            presenter.login(email: "test@test.com", password: "1234")
                            expect(router.loginCalled).to(beFalse())
                            expect(view.error) == "Invalid credentials"
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

    func showError(_ error: String) {
        self.error = error
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
    func login(input: LoginInput, callback: @escaping (Response<LoginOutput>) -> ()) {
        if input.password == "123456" {
            callback(Response<LoginOutput>(data: LoginOutput(authToken: "1234567"), result: .success))
        } else {
            callback(Response<LoginOutput>(data: nil, result: .error(message: "Invalid credentials")))
        }
    }
}
