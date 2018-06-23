import Quick
import Nimble

@testable import ToDo

class SignUpNameStepTests: QuickSpec {
    
    override func spec() {
 
        var view: SignUpNameStepViewSpy!
        var presenter: SignUpNameStepPresenter!
        var router: SignUpNameStepViewRouterSpy!
        
        describe("SignUpNameStepPresenter") {
            
            beforeEach {
                view = SignUpNameStepViewSpy()
                router = SignUpNameStepViewRouterSpy()
                presenter = SignUpNameStepPresenter(view: view, router: router)
            }
            
            describe("when user tries to move forward with signup") {

                context("and didn't filled the name text field") {
                    it("should show a proper error message") {
                        presenter.moveForward(name: "")
                        expect(view.error) == "Invalid name"
                    }
                }

                context("and filled the name properly") {
                    it("should move forward normally") {
                        presenter.moveForward(name: "Jon Snow")
                        expect(view.error).to(beNil())
                        expect(router.presentEmailStepCalled).to(beTrue())
                    }
                }
            }

            describe("when user tries to close sign up view") {
                it("should call dismiss action normally") {
                    presenter.dismiss()
                    expect(router.dismissCalled).to(beTrue())
                }
            }
        }
    }
}

private class SignUpNameStepViewSpy: SignUpNameStepView {
    var error: String?

    func showError(_ error: String) {
        self.error = error
    }
}

private class SignUpNameStepViewRouterSpy: SignUpNameStepViewRouter {
    var presentEmailStepCalled: Bool = false
    var dismissCalled: Bool = false

    func presentEmailStep(name: String) {
        presentEmailStepCalled = true
    }

    func dismiss() {
        dismissCalled = true
    }
}
