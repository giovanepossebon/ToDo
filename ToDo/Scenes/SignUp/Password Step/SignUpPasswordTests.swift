import Quick
import Nimble

@testable import ToDo

class SignUpPasswordTests: QuickSpec {
    
    override func spec() {
 
        var view: SignUpPasswordViewSpy!
        var router: SignUpPasswordRouterSpy!
        var service: SignUpPasswordServiceMock!
        var presenter: SignUpPasswordPresenter!
        
        describe("SignUpPasswordPresenter") {
            
            beforeEach {
                view = SignUpPasswordViewSpy()
                router = SignUpPasswordRouterSpy()
                service = SignUpPasswordServiceMock()

                let viewModel = SignUpPasswordPresenter.ViewModel(name: "Jon", email: "jon@me.com")
                presenter = SignUpPasswordPresenter(view: view, router: router, service: service, viewModel: viewModel)
            }

            describe("when user tries to sign up") {

                context("and password field is empty") {
                    it("then it should show a error message") {
                        presenter.signUp(password: "", repassword: "123456")
                        expect(view.error) == "The password field is required"
                        expect(router.successCalled).to(beFalse())
                    }
                }

                context("and password confirmation field is empty") {
                    it("then it should show a error message") {
                        presenter.signUp(password: "123456", repassword: "")
                        expect(view.error) == "The password field is required"
                        expect(router.successCalled).to(beFalse())
                    }
                }

                context("and passwords are different") {
                    it("then it should show a error message") {
                        presenter.signUp(password: "123", repassword: "321")
                        expect(view.error) == "The passwords are different"
                        expect(router.successCalled).to(beFalse())
                    }
                }

                context("and password and password confirmation fields are empty") {
                    it("then it should show a error message") {
                        presenter.signUp(password: "", repassword: "")
                        expect(view.error) == "The password field is required"
                        expect(router.successCalled).to(beFalse())
                    }
                }

                context("and both passwords fields are filled properly") {
                    it("then it should call sign up service") {
                        presenter.signUp(password: "123456", repassword: "123456")
                        expect(view.error).to(beNil())
                        expect(router.successCalled).to(beTrue())
                    }
                }
            }

        }
    }
}

private class SignUpPasswordViewSpy: SignUpPasswordView {
    var error: String?

    func showError(_ error: String) {
        self.error = error
    }
}

private class SignUpPasswordRouterSpy: SignUpPasswordViewRouter {
    var successCalled: Bool = false

    func toSuccess(message: String) {
        successCalled = true
    }
}

private class SignUpPasswordServiceMock: SignupServiceContract {
    func signUp(input: SignupInput, callback: @escaping (Response<SignupOutput>) -> ()) {
        callback(Response<SignupOutput>(data: SignupOutput(message: "Account created successfully", authToken: "12345678"), result: .success))
    }
}
