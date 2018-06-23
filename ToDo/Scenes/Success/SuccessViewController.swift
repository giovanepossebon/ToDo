import UIKit

class SuccessViewController: UIViewController {
    
    @IBOutlet private weak var labelMessage: UILabel!

    // MARK: Properties
    
    var presenter: SuccessPresenter?
    
    // MARK: Initialization
    
    init() {
        super.init(nibName: "SuccessViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad(viewController: self)
    }

}


extension SuccessViewController: SuccessView {
    func setMessage(_ text: String) {
        labelMessage.text = text
    }
}
