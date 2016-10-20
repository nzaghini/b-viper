import Quick
import Nimble
@testable import Weather


class WeatherLocationDefaultPresenterSpec: QuickSpec {
    
    var viewMock: WeatherLocationViewMock!
    var interactorMock: WeatherLocationInteractorMock!
    var routerMock: WeatherLocationRouterMock!
    
    var presenter: WeatherLocationDefaultPresenter!
        
    override func spec() {
        
        beforeEach {
            self.viewMock = WeatherLocationViewMock()
            self.interactorMock = WeatherLocationInteractorMock()
            self.routerMock = WeatherLocationRouterMock()
            
            self.presenter = WeatherLocationDefaultPresenter(view: self.viewMock,
                                                             interactor: self.interactorMock,
                                                             router: self.routerMock)
        }
        
        context("When viewIsReady is called") {
            it("Should call displaySearch to the view") {
                self.presenter.loadContent()
                
                expect(self.viewMock.displaySearchCalled).to(beTrue())
            }
        }
        
        context("When userSearchText is called with empty text") {
            it("Should do nothing") {
                self.presenter.searchLocation("")
                
                expect(self.viewMock.displayLocationsCalled).to(beFalse())
                expect(self.interactorMock.locationsWithTextCalled).to(beFalse())
            }
        }
        
        context("When userSearchText is called with text") {
            it("Should call the interactor with the text") {
                self.presenter.searchLocation("text")
                
                expect(self.viewMock.displayLoadingCalled).to(beTrue())
                expect(self.interactorMock.locationsWithTextCalled).to(beTrue())
                expect(self.interactorMock.textCalled).to(equal("text"))
            }
        }
        
        context("When userSearchText is called and the interactor returns no locations") {
            it("Should call displayNoResults on the view") {
                let result = FindLocationResult.Success(locations: [])
                self.interactorMock.resultToReturn = result
                
                self.presenter.searchLocation("text")
                
                expect(self.viewMock.displayNoResultsCalled).to(beTrue())
            }
        }
        
        context("When userSearchText is called and the interactor returns an error") {
            it("Should call displayErrorMessage on the view") {
                let error = NSError(domain: NSURLErrorDomain, code: 500, userInfo: nil)
                self.interactorMock.resultToReturn = FindLocationResult.Failure(reason: error)
                
                self.presenter.searchLocation("text")
                
                expect(self.viewMock.displayErrorMessageCalled).to(beTrue())
            }
        }
        
        context("When userSearchText is called and the interactor returns some locations") {
            it("Should call displayLocations on the view") {
                let location = Location.locationWithIndex(1)
                self.interactorMock.resultToReturn = FindLocationResult.Success(locations: [location])
                
                self.presenter.searchLocation("text")
                
                expect(self.viewMock.displayLocationsCalled).to(beTrue())
                if let viewModel = self.viewMock.locationsCalled {
                    expect(viewModel.locations.count).to(equal(1))
                }
            }
        }
        
        context("When userSelectLocation is called") {
            it("Should call the interactor and navigate back") {
                let location = Location.locationWithIndex(1)
                self.interactorMock.resultToReturn = FindLocationResult.Success(locations: [location])
                
                self.presenter.searchLocation("text")
                
                self.presenter.selectLocation(location.locationId)
                
                expect(self.interactorMock.selectLocationCalled).to(beTrue())
                expect(self.routerMock.navigationBackCalled).to(beTrue())
                
                guard let locationCalled = self.interactorMock.locationCalled else {
                    fail()
                    return
                }
                
                expect(locationCalled.locationId).to(equal("1"))
            }
        }
        
        context("When userCancel is called") {
            it("Should navigate back") {
                self.presenter.cancelSearchForLocation()
                
                expect(self.routerMock.navigationBackCalled).to(beTrue())
            }
        }
        
    }
    
}



// MARK: Mocks

class WeatherLocationInteractorMock: WeatherLocationInteractor {
    
    var locationsWithTextCalled = false
    var textCalled: String?
    var selectLocationCalled = false
    var locationCalled: Location?
    var resultToReturn: FindLocationResult?
    
    func findLocation(text: String, completion: (FindLocationResult) -> ()) {
        self.locationsWithTextCalled = true
        self.textCalled = text
        
        if let result = self.resultToReturn {
            completion(result)
        }
    }
    
    func selectLocation(location: Location) {
        self.selectLocationCalled = true
        self.locationCalled = location
    }
    
}


class WeatherLocationViewMock: WeatherLocationView {
    
    var displayLoadingCalled = false
    var displaySearchCalled = false
    var displayNoResultsCalled = false
    var displayErrorMessageCalled = false
    var errorMessageCalled: String?
    var displayLocationsCalled = false
    var locationsCalled: SelectableLocationListViewModel?
    
    func displayLoading() {
        self.displayLoadingCalled = true
    }
    
    func displaySearch() {
        self.displaySearchCalled = true
    }
    
    func displayNoResults() {
        self.displayNoResultsCalled = true
    }
    
    func displayErrorMessage(errorMessage: String) {
        self.displayErrorMessageCalled = true
        self.errorMessageCalled = errorMessage
    }
    
    func displayLocations(viewModel: SelectableLocationListViewModel) {
        self.displayLocationsCalled = true
        self.locationsCalled = viewModel
    }
    
}

class WeatherLocationRouterMock: WeatherLocationRouter {
    
    var navigationBackCalled = false
    
    func navigateBack() {
        self.navigationBackCalled = true
    }
    
}
