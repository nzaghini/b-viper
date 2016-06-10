import UIKit

class WeatherDetailViewController: UIViewController, WeatherDetailView {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var todayTemperatureLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    var presenter: WeatherDetailPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cityLabel.text = ""
        self.todayTemperatureLabel.text = ""
        
        self.presenter?.loadContent()
    }
    
    // MARK: - WeatherDetailView
    
    func displayWeatherDetail(viewModel: WeatherDetailViewModel) {
        self.cityLabel.text = viewModel.cityName
        self.todayTemperatureLabel.text = viewModel.temperature
        
        for forecast in viewModel.forecasts {
            let forecastView = NSBundle.mainBundle().loadNibNamed("WeatherForecastView", owner: nil, options: nil).first as! WeatherForecastView
            forecastView.dayLabel.text = forecast.day
            forecastView.tempLabel.text = forecast.temp
            
            self.stackView.addArrangedSubview(forecastView)
        }
    }
    
    func displayError(errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        alert.addAction(cancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
