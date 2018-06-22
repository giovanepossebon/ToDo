import UIKit

protocol LoginView: class {
    func showError(_ error: String)
}

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var textFieldEmail: UITextField!
    @IBOutlet private weak var textFieldPassword: UITextField!

    // MARK: Properties
    
    private var presenter: LoginPresenter?
    
    // MARK: Initialization
    
    init() {
        super.init(nibName: "LoginViewController", bundle: nil)
        presenter = LoginPresenter(view: self)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }

    // MARK: IBActions

    @IBAction func didTouchLogin(_ sender: Any) {
        presenter?.login(email: textFieldEmail.text, password: textFieldPassword.text)
    }

    @IBAction func didTouchSignUp(_ sender: Any) {
        presenter?.signUp()
    }
}


extension LoginViewController: LoginView {
    func showError(_ error: String) {
        let alert = UIAlertController(title: "Hey", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
