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
    
    // MARK: Initialization
    
    required init(view: LoginView, router: LoginViewRouter) {
        self.view = view
        self.router = router
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

        let request = LoginInput(email: email, password: password)

        LoginService.login(input: request) { [weak self] output in
            switch output.result {
            case .success:
                guard let output = output.data else {
                    self?.view.showError("Unexpected Error")
                    return
                }

                UserSession.shared.authToken = output.authToken
            case .error(message: let error):
                self?.view.showError(error)
            }
        }
    }

    func signUp() {
        router.presentSignUp()
    }

}
