import XCTest

@testable import SportsProject

final class RemoteDataSourceTestCase: XCTestCase {
    
    
    var remote: RemoteDataSourceImpl!

    override func setUpWithError() throws {
        self.remote = RemoteDataSourceImpl()
    }
    
    func testGetLeagueEventsWhenPassedWrongLeagueIdCallsError() {
        var isError = false
        let exp = expectation(description: "Started Fetching events")
        
        self.remote.getLeagueEvents(sport: .FOOTBALL, leagueId: -2, from: Date(), to: Date()) { _ in
            
        } onFailure: { error in
            isError = true
            XCTAssertTrue(isError)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
    
//    func testGetTeamsByLeagueIdWhenPassedWrongLeagueIdCallsError() {
//        var isError = false
//        let exp = expectation(description: "started fetching teams")
//        self.remote.getTeamsByLeagueId(sport: .BASKETBALL, leagueId: -1) { teams in
//
//        } onFailure: { error in
//            isError = true
//            XCTAssertTrue(isError)
//            exp.fulfill()
//        }
//
//        wait(for: [exp], timeout: 5)
//    }
//
    
//    func testGetTeamsByLeagueIdWhenAllInputIsValidReturnsMoreThan10Teams() {
//        let exp = expectation(description: "started fetching teams")
//        self.remote.getTeamsByLeagueId(sport: .FOOTBALL, leagueId: 4) { teams in
//            XCTAssertGreaterThan(teams.count, 10)
//            exp.fulfill()
//
//        } onFailure: { error in
//
//        }
//
//        wait(for: [exp], timeout: 5)
//    }
//

    func testGetLeaguesBySportWhenAllInputIsCorrectReturnsNonEmptyLeagues() {
        
        let exp = expectation(description: "Started fetching leagues")
        
        self.remote.getLeaguesBySport(sport: .FOOTBALL) { leagues in
            XCTAssertGreaterThan(leagues.count, 0)
            exp.fulfill()
        } onFailure: { error in
            
        }
        wait(for: [exp], timeout: 5)
    }
    
    

}
