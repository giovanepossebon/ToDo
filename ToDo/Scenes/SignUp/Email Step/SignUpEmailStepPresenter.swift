import UIKit

protocol SignUpEmailStepView: class {
    func showError(_ error: String)
}

protocol SignUpEmailStepViewPresenter: class {
    func moveForward(email: String?)
    var router: SignUpEmailStepViewRouter { get }
}

class SignUpEmailStepPresenter: SignUpEmailStepViewPresenter {
    
    // MARK: Properties
    
    unowned let view: SignUpEmailStepView
    internal let router: SignUpEmailStepViewRouter
    internal let viewModel: ViewModel

    // MARK: Initialization

    required init(view: SignUpEmailStepView, router: SignUpEmailStepViewRouter, viewModel: ViewModel) {
        self.view = view
        self.router = router
        self.viewModel = viewModel
    }
    
    // MARK: Public API

    func moveForward(email: String?) {
        guard let email = email, !email.isEmpty else {
            view.showError("Invalid email")
            return
        }

        router.presentPassword(name: viewModel.name, email: email)
    }

}
