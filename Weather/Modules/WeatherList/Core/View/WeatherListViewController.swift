import Foundation
import UIKit

class WeatherListViewController: UITableViewController, WeatherListView {
    
    var viewModel: LocationListViewModel?
    var presenter: WeatherListPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.addButtonItem()
        
        self.presenter?.loadContent()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.presenter?.loadContent()
    }
    
    // MARK: - CityListView
    
    func displayLocationList(viewModel: LocationListViewModel) {
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
            return viewModel.locations.count
        }
        return 0
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("WeatherCell")
        if cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "WeatherCell")
            cell?.accessoryType = .DisclosureIndicator
        }
        
        if let item = self.viewModel?.locations[indexPath.row] {
            cell?.textLabel?.text = item.name
            cell?.detailTextLabel?.text = item.detail
        }
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let viewModel = self.viewModel {
            let locationId = viewModel.locations[indexPath.row].locationId
            self.presenter?.presentWeatherDetail(locationId)
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
