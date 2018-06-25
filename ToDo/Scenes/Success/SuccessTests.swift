import Quick
import Nimble

@testable import ToDo

class SuccessTests: QuickSpec {
    
    override func spec() {
 
        var view: SuccessViewSpy!
        var delegate: SuccessDelegateSpy!
        var presenter: SuccessPresenter!
        
        describe("SuccessPresenter") {
            
            beforeEach {
                view = SuccessViewSpy()
                delegate = SuccessDelegateSpy()

                let viewModel = SuccessPresenter.ViewModel(message: "Test message")
                presenter = SuccessPresenter(view: view, viewModel: viewModel, delegate: delegate)
            }
            
            describe("when view is loaded") {
                
                beforeEach {
                    presenter.viewDidLoad(viewController: UIViewController())
                }

                it("then it sets the message title properly") {
                    expect(view.message) == "Test message"
                }

                context("and 2 seconds passed") {

                    it("then it shouldn't dismiss the view yet") {
                        presenter.viewDidLoad(viewController: UIViewController())
                        expect(delegate.dismissCalled).toEventually(beFalse(), timeout: 2.0)
                    }

                }

                context("and 6 seconds has passed") {

                    it("then it should dismiss the view") {
                        presenter.viewDidLoad(viewController: UIViewController())
                        expect(delegate.dismissCalled).toEventually(beTrue(), timeout: 6.0)
                    }
                }
                
            }
        }
    }
}

private class SuccessViewSpy: SuccessView {
    var message: String?

    func setMessage(_ text: String) {
        message = text
    }
}

private class SuccessDelegateSpy: SuccessDelegate {
    var dismissCalled: Bool = false

    func successDidDismiss(viewController: UIViewController) {
        dismissCalled = true
    }
}
