import UIKit

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
        let alert = UIAlertController(title: "Hey!", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
