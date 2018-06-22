import Quick
import Nimble

@testable import ToDo

class SignUpEmailStepTests: QuickSpec {
    
    override func spec() {
 
        var view: SignUpEmailStepViewSpy!
        var presenter: SignUpEmailStepPresenter!
        var router: SignUpEmailStepViewRouterSpy!
        
        describe("SignUpEmailStepPresenter") {
            
            beforeEach {
                let viewModel = SignUpEmailStepPresenter.ViewModel(name: "Jon Snow")
                view = SignUpEmailStepViewSpy()
                router = SignUpEmailStepViewRouterSpy()
                presenter = SignUpEmailStepPresenter(view: view, router: router, viewModel: viewModel)
            }

            describe("when view is loaded") {

                it("should have the name information from previous step") {
                    expect(presenter.viewModel.name) == "Jon Snow"
                }

            }

            describe("when user tries to move forward with sign up") {

                context("and didn't filled the email text field") {
                    it("should show a proper error message") {
                        presenter.moveForward(email: "")
                        expect(view.error) == "Invalid email"
                        expect(router.presentPasswordCalled).to(beFalse())
                    }
                }

                context("and filled the email properly") {
                    it("should move forward normally") {
                        presenter.moveForward(email: "test@test.com")
                        expect(view.error).to(beNil())
                        expect(router.presentPasswordCalled).to(beTrue())
                    }
                }

            }
        }
    }
}

private class SignUpEmailStepViewSpy: SignUpEmailStepView {
    var error: String?

    func showError(_ error: String) {
        self.error = error
    }
}

private class SignUpEmailStepViewRouterSpy: SignUpEmailStepViewRouter {
    var presentPasswordCalled: Bool = false

    func presentPassword(email: String) {
        presentPasswordCalled = true
    }
}
