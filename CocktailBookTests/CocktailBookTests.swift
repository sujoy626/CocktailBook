import XCTest
@testable import CocktailBook


class CocktailBookTests: XCTestCase {
    let sut = AllProductViewModel(service: MockCocktailService())
    
    
    func clearCocktails(){
        sut.cocktailsStorage.removeAll()
        sut.cocktails.removeAll()
    }
    
    func testAllCocktails(){
        
        XCTAssertNotEqual(sut.cocktails.count, 0)
        
        XCTAssertEqual(sut.cocktails.count, 13)
        
        
        //check all filter
        sut.doFilter(with: .alcoholic)
        XCTAssertEqual(sut.cocktails.count, 9)
        
        
        sut.doFilter(with: .nonAlcoholic)
        XCTAssertEqual(sut.cocktails.count, 4)
        
        sut.doFilter(with: .all)
        XCTAssertEqual(sut.cocktails.count, 13)
        
        
        
        //remove all cocktails
        clearCocktails()
        
        XCTAssertEqual(sut.cocktails.count, 0)
        
    }
}


