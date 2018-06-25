import UIKit

protocol LoginView: class {
    func showError(_ error: String)
    func showSpinner()
    func dismissSpinner()
}

protocol LoginViewPresenter {
    init(view: LoginView, router: LoginViewRouter, service: LoginServiceContract)
    func login(email: String?, password: String?)
    func signUp()
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
        view.showSpinner()
        service.login(input: input) { [weak self] output, error in
            self?.view.dismissSpinner()

            guard error == nil else {
                self?.view.showError(error?.message ?? "")
                return
            }

            if !isRunningUnitTests() {
                guard let token = output?.authToken else {
                    self?.view.showError("Unexpected error")
                    return
                }

                UserSession.shared.authToken = token
            }

            self?.router.login()
        }
    }

    func signUp() {
        router.presentSignUp()
    }

}
