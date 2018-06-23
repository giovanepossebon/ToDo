import UIKit

protocol SuccessView: class {
    func setMessage(_ text: String)
}

protocol SuccessDelegate: class {
    func successDidDismiss(viewController: UIViewController)
}

protocol SuccessViewPresenter: class {
    func viewDidLoad(viewController: UIViewController)
}

class SuccessPresenter: SuccessViewPresenter {
    
    // MARK: Properties
    
    unowned let view: SuccessView
    private unowned var delegate: SuccessDelegate
    private let viewModel: ViewModel
    
    // MARK: Initialization
    
    init(view: SuccessView, viewModel: ViewModel, delegate: SuccessDelegate) {
        self.view = view
        self.viewModel = viewModel
        self.delegate = delegate
    }
    
    // MARK: Public API

    func viewDidLoad(viewController: UIViewController) {
        view.setMessage(viewModel.message)
        
        dismiss(viewController: viewController, delay: 3.0)
    }

    private func dismiss(viewController: UIViewController, delay: TimeInterval) {
        Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { [weak self] _ in
            self?.delegate.successDidDismiss(viewController: viewController)
        }
    }

}
