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
                self.presenter.viewIsReady()
                
                expect(self.viewMock.displaySearchCalled).to(beTrue())
            }
        }
        
        context("When userSearchText is called with empty text") {
            it("Should do nothing") {
                self.presenter.userSearchText("")
                
                expect(self.viewMock.displayLocationsCalled).to(beFalse())
                expect(self.interactorMock.locationsWithTextCalled).to(beFalse())
            }
        }
        
        context("When userSearchText is called with text") {
            it("Should call the interactor with the text") {
                self.presenter.userSearchText("text")
                
                expect(self.viewMock.displayLoadingCalled).to(beTrue())
                expect(self.interactorMock.locationsWithTextCalled).to(beTrue())
                expect(self.interactorMock.textCalled).to(equal("text"))
            }
        }
        
        context("When userSearchText is called and the interactor returns no locations") {
            it("Should call displayNoResults on the view") {
                let result = FetchWeatherLocationResult.Success(locations: [])
                self.interactorMock.resultToReturn = result
                
                self.presenter.userSearchText("text")
                
                expect(self.viewMock.displayNoResultsCalled).to(beTrue())
            }
        }
        
        context("When userSearchText is called and the interactor returns an error") {
            it("Should call displayErrorMessage on the view") {
                let error = NSError(domain: NSURLErrorDomain, code: 500, userInfo: nil)
                self.interactorMock.resultToReturn = FetchWeatherLocationResult.Failure(reason: error)
                
                self.presenter.userSearchText("text")
                
                expect(self.viewMock.displayErrorMessageCalled).to(beTrue())
            }
        }
        
        context("When userSearchText is called and the interactor returns some locations") {
            it("Should call displayLocations on the view") {
                let location = WeatherLocation.locationWithIndex(1)
                self.interactorMock.resultToReturn = FetchWeatherLocationResult.Success(locations: [location])
                
                self.presenter.userSearchText("text")
                
                expect(self.viewMock.displayLocationsCalled).to(beTrue())
                if let locations = self.viewMock.locationsCalled {
                    expect(locations.count).to(equal(1))
                }
            }
        }
        
        context("When userSelectLocation is called") {
            it("Should call the interactor and navigate back") {
                let location = WeatherLocation.locationWithIndex(1)
                self.interactorMock.resultToReturn = FetchWeatherLocationResult.Success(locations: [location])
                
                self.presenter.userSearchText("text")
                
                guard let viewModel = self.viewMock.locationsCalled?.first else {
                    fail()
                    return
                }
                
                self.presenter.userSelectLocation(viewModel)
                
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
                self.presenter.userCancel()
                
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
    var locationCalled: WeatherLocation?
    var resultToReturn: FetchWeatherLocationResult?
    
    func locationsWithText(text: String, completion: (FetchWeatherLocationResult) -> ()) {
        self.locationsWithTextCalled = true
        self.textCalled = text
        
        if let result = self.resultToReturn {
            completion(result)
        }
    }
    
    func selectLocation(location: WeatherLocation) {
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
    var locationsCalled: [WeatherLocationViewModel]?
    
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
    
    func displayLocations(locations: [WeatherLocationViewModel]) {
        self.displayLocationsCalled = true
        self.locationsCalled = locations
    }
    
}

class WeatherLocationRouterMock: WeatherLocationRouter {
    
    var navigationBackCalled = false
    
    func navigateBack() {
        self.navigationBackCalled = true
    }
    
}
