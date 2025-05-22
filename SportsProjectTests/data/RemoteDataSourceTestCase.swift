import XCTest

@testable import SportsProject

final class RemoteDataSourceTestCase: XCTestCase {
    
    
    var remote: RemoteDataSourceImpl!

    override func setUpWithError() throws {
        self.remote = RemoteDataSourceImpl()
    }
    
    func testGetLeagueEventsWhenAllDataIsCorrectGetsNonEmptyList() {
        let exp = expectation(description: "Started Fetching events")
        var componenets = DateComponents()
        componenets.year = 2025
        componenets.month = 5
        componenets.day = 1
        let startDate = Calendar.current.date(from: componenets) ?? Date()
        componenets.day = 2
        let endDate = Calendar.current.date(from: componenets) ?? Date()
    
        
        self.remote.getLeagueEvents(sport: .FOOTBALL, leagueId: 4, from: startDate, to: endDate) { events in
            XCTAssertGreaterThan(events.count, 0)
            exp.fulfill()
        } onFailure: { error in
            
        }
        wait(for: [exp], timeout: 20)
    }
    
    func testGetTeamsByLeagueIdWhenPassedWrongLeagueIdCallsError() {
        var isError = false
        let exp = expectation(description: "started fetching teams")
        self.remote.getTeamsByLeagueId(sport: .BASKETBALL, leagueId: -1) { teams in

        } onFailure: { error in
            isError = true
            XCTAssertTrue(isError)
            exp.fulfill()
        }

        wait(for: [exp], timeout: 5)
    }

    
    func testGetTeamsByLeagueIdWhenAllInputIsValidReturnsMoreThan10Teams() {
        let exp = expectation(description: "started fetching teams")
        self.remote.getTeamsByLeagueId(sport: .FOOTBALL, leagueId: 4) { teams in
            XCTAssertGreaterThan(teams.count, 10)
            exp.fulfill()

        } onFailure: { error in

        }

        wait(for: [exp], timeout: 5)
    }


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
