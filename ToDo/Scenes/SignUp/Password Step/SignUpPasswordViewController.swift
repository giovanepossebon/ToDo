import UIKit
import SVProgressHUD

class SignUpPasswordViewController: UIViewController, NavigationBarManager {
    
    @IBOutlet private weak var textFieldPassword: UITextField! {
        didSet {
            textFieldPassword.delegate = self
        }
    }

    @IBOutlet private weak var textFieldRePassword: UITextField! {
        didSet {
            textFieldRePassword.delegate = self
        }
    }

    // MARK: Properties
    
    var presenter: SignUpPasswordPresenter?
    
    // MARK: Initialization
    
    init() {
        super.init(nibName: "SignUpPasswordViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        textFieldPassword.becomeFirstResponder()
        setupNavigationBar(title: "Sign Up")
    }
}

extension SignUpPasswordViewController: SignUpPasswordView {
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

extension SignUpPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldPassword {
            textFieldRePassword.becomeFirstResponder()
        } else {
            presenter?.signUp(password: textFieldPassword.text, repassword: textFieldRePassword.text)
        }

        return true
    }
}
