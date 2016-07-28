import UIKit

class WeatherLocationViewController: UIViewController, WeatherLocationView {

    var presenter: WeatherLocationPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(cancelAction))
    }
    
    // MARK: Actions
    
    func cancelAction() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
