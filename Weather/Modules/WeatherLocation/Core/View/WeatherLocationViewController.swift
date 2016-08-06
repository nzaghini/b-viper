import UIKit
import ASToast


class WeatherLocationViewController: UIViewController,
    WeatherLocationView, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: WeatherLocationPresenter?
    var locations: [WeatherLocationViewModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = UIRectEdge.None
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(cancelAction))
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.keyboardDismissMode = .OnDrag
        
        self.searchBar.delegate = self
        self.spinner.hidesWhenStopped = true
        
        self.presenter?.viewIsReady()
    }
    
    // MARK: Actions
    
    func cancelAction() {
        self.searchBar.resignFirstResponder()
        self.presenter?.userCancel()
    }
    
    // MARK: <WeatherLocationView>
    
    func displayLoading() {
        self.searchBar.hidden = false
        self.tableView.hidden = true
        self.spinner.startAnimating()
    }
    
    func displaySearch() {
        self.searchBar.hidden = false
        self.tableView.hidden = false
        self.spinner.stopAnimating()
        
        self.searchBar.becomeFirstResponder()
    }
    
    func displayNoResults() {
        self.searchBar.hidden = false
        self.tableView.hidden = false
        self.spinner.stopAnimating()
        
        self.locations = nil
        self.tableView.reloadData()
        
        self.showToastWithText("No Results")
    }
    
    func displayErrorMessage(errorMessage: String) {
        self.searchBar.hidden = false
        self.tableView.hidden = false
        self.spinner.stopAnimating()
        
        self.showToastWithText(errorMessage)
    }
    
    func displayLocations(locations: [WeatherLocationViewModel]) {
        self.searchBar.hidden = false
        self.tableView.hidden = false
        self.spinner.stopAnimating()
        
        self.locations = locations
        self.tableView.reloadData()
    }
    
    // MARK: <UISearchBarDelegate>
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if let text = searchBar.text {
            self.presenter?.userSearchText(text)
        }
    }
    
    // MARK: <UITableViewDelegate>
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let location = self.locations?[indexPath.row] {
            self.presenter?.userSelectLocation(location)
        }
    }
    
    // MARK: <UITableViewDataSource>
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locations?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("WeatherLocationCell")
        if cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "WeatherLocationCell")
        }
        
        if let location = self.locations?[indexPath.row] {
            cell?.textLabel?.text = location.name
            cell?.detailTextLabel?.text = location.detail
        }
        
        return cell!
    }
    
    // MARK: Helpers
    
    private func showToastWithText(text: String) {
        self.view.makeToast(text,
                            duration: NSTimeInterval(3.0),
                            position: ASToastPosition.ASToastPositionCenter.rawValue)
    }
    
}
