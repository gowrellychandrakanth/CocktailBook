import XCTest
@testable import CocktailBook

class CocktailBookTests: XCTestCase {
    
    var cocktailDataManager: CocktailDataManager!
    var cocktailsAPI: FakeCocktailsAPI!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        cocktailDataManager = CocktailDataManager()
        cocktailsAPI = FakeCocktailsAPI(withFailure: .count(1))
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cocktailDataManager = nil
        cocktailsAPI = nil
    }
    
    func test_LoadCocktailsSuccess() throws {
        // Create a fake cocktails API that always succeeds
        cocktailsAPI = FakeCocktailsAPI(withFailure: .never)
        let viewModel = CocktailMainViewModel(cocktailsAPI: cocktailsAPI, cocktailDataManager: cocktailDataManager)
        
        let expectation = XCTestExpectation(description: "Cocktails loaded successfully")
        
        viewModel.loadApi()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // Assuming that the API call takes 2 seconds to complete also expecting 13 counts, if it vary can change test accordingly
            XCTAssertEqual(viewModel.cocktailList.count, 13, "Expected 13 cocktails to be loaded")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
    }
    
    func test_LoadCocktailsFailure() throws {
        cocktailsAPI = FakeCocktailsAPI(withFailure: .count(2))
        let viewModel = CocktailMainViewModel(cocktailsAPI: cocktailsAPI, cocktailDataManager: cocktailDataManager)
        
        let expectation = XCTestExpectation(description: "Cocktails loading failed")
        
        viewModel.loadApi()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            // Can increase the time according how much time API can take
            
            XCTAssertFalse(viewModel.apiLoading, "Loading should finish after failure")
            
            // Can change below string accourding to Error message which configured
            XCTAssertTrue(viewModel.errorMessage.contains("API unavailable"), "Expected error message")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_ToggleFavourite() throws {
        let cocktail = CocktailModel(
            id: "7",
            name: "Margarita",
            type: "alcoholic",
            shortDescription: "A sweet tequila-based party drink that's easy to make in batches.",
            longDescription: "A margarita is a cocktail consisting of tequila, orange liqueur, and lime juice often served with salt on the rim of the glass. The drink is served shaken with ice, blended with ice, or without ice.",
            preparationMinutes: 5,
            imageName: "margarita",
            ingredients: [
                "1 (6 ounce) can frozen limeade concentrate",
                "6 fluid ounces tequila",
                "2 fluid ounces triple sec"
            ],
            isFavorite: false
        )
        
        cocktailDataManager.addData(cocktail.id)
        XCTAssertTrue(cocktailDataManager.loadAll().contains(cocktail.id), "Cocktail should be a favorite")
        
        cocktailDataManager.removeData(cocktail.id)
        XCTAssertFalse(cocktailDataManager.loadAll().contains(cocktail.id), "Cocktail should not be a favorite")
    }
    
    func test_PerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            _ = cocktailDataManager.loadAll()
        }
    }
}
