import UIKit

protocol LoginViewPresenter {
    func login(email: String?, password: String?)
    func signUp()
    var router: LoginViewRouter { get }
}

class LoginPresenter: LoginViewPresenter {

    // MARK: Properties
    
    unowned let view: LoginView
    internal let router: LoginViewRouter
    private let service: LoginServiceContract

    // MARK: Initialization
    
    required init(view: LoginView, router: LoginViewRouter, service: LoginServiceContract) {
        self.view = view
        self.router = router
        self.service = service
    }
    
    // MARK: Public API

    func login(email: String?, password: String?) {
        guard let email = email, !email.isEmpty else {
            view.showError("Invalid email")
            return
        }

        guard let password = password, !password.isEmpty else {
            view.showError("Invalid password")
            return
        }

        let input = LoginInput(email: email, password: password)
        service.login(input: input) { [weak self] success, error in
            if success {
                self?.router.login()
            } else {
                self?.view.showError(error?.message ?? "")
            }
        }
    }

    func signUp() {
        router.presentSignUp()
    }

}
