import UIKit

protocol EditPopupView: class {
    func setTextFieldValue(_ text: String)
}

protocol EditPopupDelegate: class {
    func editPopupDidConfirm(_ viewController: UIViewController, newValue: String, for id: Int)
    func editPopupDidDismiss(_ viewController: UIViewController)
}

protocol EditPopupViewPresenter {
    init(delegate: EditPopupDelegate, view: EditPopupView, viewModel: EditPopupPresenter.ViewModel)
    func confirm(from viewController: UIViewController, newValue: String?)
    func dismiss(from viewController: UIViewController)
    func viewDidLoad()
}

class EditPopupPresenter: EditPopupViewPresenter {
    
    // MARK: Properties
    
    private unowned let view: EditPopupView
    private unowned let delegate: EditPopupDelegate
    private let viewModel: ViewModel
    
    // MARK: Initialization
    
    required init(delegate: EditPopupDelegate, view: EditPopupView, viewModel: ViewModel) {
        self.delegate = delegate
        self.view = view
        self.viewModel = viewModel
    }
    
    // MARK: Public API

    func viewDidLoad() {
        view.setTextFieldValue(viewModel.value)
    }

    func confirm(from viewController: UIViewController, newValue: String?) {
        guard let value = newValue, !value.isEmpty else { return }

        delegate.editPopupDidConfirm(viewController, newValue: value, for: viewModel.id)
    }

    func dismiss(from viewController: UIViewController) {
        delegate.editPopupDidDismiss(viewController)
    }
}
