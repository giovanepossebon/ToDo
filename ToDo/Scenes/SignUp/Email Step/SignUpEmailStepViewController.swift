import UIKit

class SignUpEmailStepViewController: UIViewController, NavigationBarManager {

    // MARK: IBOutlets

    @IBOutlet private weak var textFieldEmail: UITextField! {
        didSet {
            textFieldEmail.delegate = self
        }
    }

    // MARK: Properties
    
    var presenter: SignUpEmailStepPresenter?
    
    // MARK: Initialization
    
    init() {
        super.init(nibName: "SignUpEmailStepViewController", bundle: nil)

    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar(title: "Sign Up")

        textFieldEmail.becomeFirstResponder()
    }

}

// MARK: SignUpEmailStepView

extension SignUpEmailStepViewController: SignUpEmailStepView {
    func showError(_ error: String) {
        self.present(UIAlertController.errorAlert(message: error), animated: true, completion: nil)
    }
}

// MARK: UITextFieldDelegate

extension SignUpEmailStepViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        presenter?.moveForward(email: textField.text)

        return true
    }

}
