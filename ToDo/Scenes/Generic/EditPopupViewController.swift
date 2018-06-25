import UIKit

class EditPopupViewController: UIViewController {

    // MARK: IBOutlets

    @IBOutlet private weak var textFieldEdit: UITextField!
    @IBOutlet private weak var buttonOk: UIButton!

    // MARK: Properties
    
    var presenter: EditPopupPresenter?
    
    // MARK: Initialization
    
    init() {
        super.init(nibName: "EditPopupViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
        textFieldEdit.becomeFirstResponder()
    }

    // MARK: IBActions

    @IBAction func didTouchOkButton(_ sender: Any) {
        presenter?.confirm(from: self, newValue: textFieldEdit.text)
    }
    
    @IBAction func didTouchClose(_ sender: Any) {
        presenter?.dismiss(from: self)
    }
}

// MARK: EditPopupView

extension EditPopupViewController: EditPopupView {
    func setTextFieldValue(_ text: String) {
        textFieldEdit.text = text
    }
}
