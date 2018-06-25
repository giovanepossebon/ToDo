import Quick
import Nimble

@testable import ToDo

class EditPopupTests: QuickSpec {
    
    override func spec() {
 
        var view: EditPopupViewSpy!
        var delegate: EditPopupDelegateSpy!
        var presenter: EditPopupPresenter!
        
        describe("EditPopupPresenter") {
            
            beforeEach {
                view = EditPopupViewSpy()
                delegate = EditPopupDelegateSpy()
                let viewModel = EditPopupPresenter.ViewModel(id: 1, value: "School")
                presenter = EditPopupPresenter(delegate: delegate, view: view, viewModel: viewModel)
            }

            describe("when view is loaded") {

                beforeEach {
                    presenter.viewDidLoad()
                }

                it("then it should set the old value in the text field") {
                    expect(view.textFieldValue) == "School"
                }

            }

            describe("when the user sets a new value") {

                context("and the text field is filled") {

                    it("then it should call confirm delegate") {
                        presenter.confirm(from: UIViewController(), newValue: "Market")
                        expect(delegate.confirmCalled).to(beTrue())
                    }

                }

                context("and the text field is not filled") {

                    it("then it shouldn't call confirm delegate") {
                        presenter.confirm(from: UIViewController(), newValue: "")
                        expect(delegate.confirmCalled).to(beFalse())
                    }

                }

            }

            describe("when the user touch on dismiss button") {

                it("then it should call dismiss delegate") {
                    presenter.dismiss(from: UIViewController())
                    expect(delegate.dismissCalled).to(beTrue())
                }

            }
        }
    }
}

private class EditPopupViewSpy: EditPopupView {
    var textFieldValue: String?

    func setTextFieldValue(_ text: String) {
        textFieldValue = text
    }
}

private class EditPopupDelegateSpy: EditPopupDelegate {
    var confirmCalled: Bool = false
    var dismissCalled: Bool = false

    func editPopupDidConfirm(_ viewController: UIViewController, newValue: String, for id: Int) {
        confirmCalled = true
    }

    func editPopupDidDismiss(_ viewController: UIViewController) {
        dismissCalled = true
    }
}
