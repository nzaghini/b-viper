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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.presenter?.loadContent()
    }
    
    // MARK: - CityListView
    
    func displayLocationList(_ viewModel: LocationListViewModel) {
        self.viewModel = viewModel
        self.tableView.reloadData()
    }
    
    func displayError(_ errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)

    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModel = self.viewModel {
            return viewModel.locations.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "WeatherCell")
            cell?.accessoryType = .disclosureIndicator
        }
        
        if let item = self.viewModel?.locations[indexPath.row] {
            cell?.textLabel?.text = item.name
            cell?.detailTextLabel?.text = item.detail
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewModel = self.viewModel {
            let locationId = viewModel.locations[indexPath.row].locationId
            self.presenter?.presentWeatherDetail(locationId)
        }
    }
    
    // MARK: - Utils
    
    func addButtonItem() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addWeatherLocation))
    }
    
    func addWeatherLocation() {
        self.presenter?.presentAddWeatherLocation()
    }
    
}
