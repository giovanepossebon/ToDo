import UIKit
import SVProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var textFieldEmail: UITextField! {
        didSet {
            textFieldEmail.delegate = self
            textFieldEmail.attributedPlaceholder = NSAttributedString(string: "Email",
                                                                      attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
        }
    }

    @IBOutlet private weak var textFieldPassword: UITextField! {
        didSet {
            textFieldPassword.delegate = self
            textFieldPassword.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                         attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
        }
    }

    // MARK: Properties
    
    var presenter: LoginPresenter?
    
    // MARK: Initialization
    
    init() {
        super.init(nibName: "LoginViewController", bundle: nil)
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
        self.present(UIAlertController.errorAlert(message: error), animated: true, completion: nil)
    }

    func showSpinner() {
        SVProgressHUD.show()
    }

    func dismissSpinner() {
        SVProgressHUD.dismiss()
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
