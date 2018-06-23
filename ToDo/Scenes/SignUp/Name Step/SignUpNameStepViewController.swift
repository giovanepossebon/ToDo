import UIKit

class SignUpNameStepViewController: UIViewController, NavigationBarManager {

    // MARK: Outlets

    @IBOutlet private weak var textFieldName: UITextField! {
        didSet {
            textFieldName.delegate = self
        }
    }

    // MARK: Properties
    
    var presenter: SignUpNameStepPresenter?
    
    // MARK: Initialization
    
    init() {
        super.init(nibName: "SignUpNameStepViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar(title: "SignUp")
        setupNavigationBarCloseButton()

        textFieldName.becomeFirstResponder()
    }

    // MARK: Private API

    private func setupNavigationBarCloseButton() {
        let barButton = UIBarButtonItem(image: #imageLiteral(resourceName: "close"), style: .done, target: self, action: #selector(close))
        navigationItem.leftBarButtonItem = barButton
    }

    @objc private func close() {
        presenter?.dismiss()
    }
}

extension SignUpNameStepViewController: SignUpNameStepView {
    func showError(_ error: String) {
        print(error)
    }
}

extension SignUpNameStepViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        presenter?.moveForward(name: textField.text)

        return true
    }

}
