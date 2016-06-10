import Foundation
import UIKit

class WeatherListViewController: UITableViewController, WeatherListView {
    
    var viewModel: WeatherListViewModel?
    var presenter: WeatherListPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.addButtonItem()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.presenter?.loadContent()
        
    }
    
    // MARK: - CityListView
    
    func displayWeatherList(viewModel: WeatherListViewModel) {
        self.viewModel = viewModel
        self.tableView.reloadData()
    }
    
    func displayError(errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        alert.addAction(cancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)

    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModel = self.viewModel {
            return viewModel.weatherItems.count
        }
        return 0
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        if let _viewModel = self.viewModel {
            cell.textLabel?.text = _viewModel.weatherItems[indexPath.row].cityName
            cell.detailTextLabel?.text = _viewModel.weatherItems[indexPath.row].temperature
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let _viewModel = self.viewModel {
            let city = _viewModel.weatherItems[indexPath.row].cityName
            self.presenter?.presentWeatherDetail(city)
        }
    }
    
    // MARK: - Utils
    
    func addButtonItem() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(self.addWeatherLocation))
    }
    
    func addWeatherLocation() {
        self.presenter?.presentAddWeatherLocation()
    }
    
}
