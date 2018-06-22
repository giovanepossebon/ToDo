import UIKit

protocol LoginView: class {
    func showError(_ error: String)
}

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var textFieldEmail: UITextField! {
        didSet {
            textFieldEmail.delegate = self
        }
    }

    @IBOutlet private weak var textFieldPassword: UITextField! {
        didSet {
            textFieldPassword.delegate = self
        }
    }

    // MARK: Properties
    
    private var presenter: LoginPresenter?
    
    // MARK: Initialization
    
    init() {
        super.init(nibName: "LoginViewController", bundle: nil)
        presenter = LoginPresenter(view: self, router: LoginViewRouterImplementation(loginViewController: self))
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textFieldEmail.resignFirstResponder()
        textFieldPassword.resignFirstResponder()
    }

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

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldEmail {
            textFieldPassword.becomeFirstResponder()
        } else {
            presenter?.login(email: textFieldEmail.text, password: textFieldPassword.text)
        }

        return true
    }
}
