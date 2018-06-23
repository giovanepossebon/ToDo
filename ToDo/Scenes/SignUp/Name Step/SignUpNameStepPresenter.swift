import UIKit

protocol SignUpNameStepView: class {
    func showError(_ error: String)
}

protocol SignUpNameStepViewPresenter: class {
    func moveForward(name: String?)
    func dismiss()
    var router: SignUpNameStepViewRouter { get }
}

class SignUpNameStepPresenter: SignUpNameStepViewPresenter {
    
    // MARK: Properties
    
    unowned let view: SignUpNameStepView
    internal let router: SignUpNameStepViewRouter
    
    // MARK: Initialization

    required init(view: SignUpNameStepView, router: SignUpNameStepViewRouter) {
        self.view = view
        self.router = router
    }

    // MARK: Public API

    func moveForward(name: String?) {
        guard let name = name, !name.isEmpty else {
            view.showError("Invalid name")
            return
        }

        router.presentEmailStep(name: name)
    }

    func dismiss() {
        router.dismiss()
    }
}
