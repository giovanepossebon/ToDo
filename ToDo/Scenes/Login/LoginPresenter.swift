import UIKit

protocol LoginViewPresenter {
    init(view: LoginView)
    func login(email: String?, password: String?)
    func signUp()
}

class LoginPresenter: LoginViewPresenter {
    
    // MARK: Properties
    
    unowned let view: LoginView
    
    // MARK: Initialization
    
    required init(view: LoginView) {
        self.view = view
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
        
    }

}
