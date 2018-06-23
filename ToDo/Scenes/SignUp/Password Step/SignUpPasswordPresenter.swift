import UIKit

protocol SignUpPasswordView: class {
    func showError(_ error: String)
    func showSpinner()
    func dismissSpinner()
}

protocol SignUpPasswordViewPresenter {
    func signUp(password: String?, repassword: String?)
    var router: SignUpPasswordViewRouter { get }
}

class SignUpPasswordPresenter: SignUpPasswordViewPresenter {
    
    // MARK: Properties
    
    unowned let view: SignUpPasswordView
    internal let router: SignUpPasswordViewRouter
    private let viewModel: ViewModel
    private let service: SignupServiceContract
    
    // MARK: Initialization
    
    init(view: SignUpPasswordView, router: SignUpPasswordViewRouter, service: SignupServiceContract, viewModel: ViewModel) {
        self.view = view
        self.router = router
        self.viewModel = viewModel
        self.service = service
    }
    
    // MARK: Public API

    func signUp(password: String?, repassword: String?) {
        guard let password = password, !password.isEmpty,
            let repassword = repassword, !repassword.isEmpty else {
                view.showError("The password field is required")
                return
        }

        guard password == repassword else {
            view.showError("The passwords are different")
            return
        }

        let input = SignupInput(name: viewModel.name,
                                email: viewModel.email,
                                password: password,
                                repassword: repassword)

        view.showSpinner()
        service.signUp(input: input) { [weak self] output, error in
            self?.view.dismissSpinner()

            guard error == nil else {
                self?.view.showError(error?.message ?? "")
                return
            }

            self?.router.toSuccess(message: output?.message ?? "")
        }
    }
}
