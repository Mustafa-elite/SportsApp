import Foundation
import CoreData
import UIKit

class LocalDataSourceImpl: LocalDataSource {
    static let shared: LocalDataSourceImpl = LocalDataSourceImpl()
    private var context: NSManagedObjectContext!
    private init() {
        self.context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    }
    
    func getAllLeagues() -> [LeagueEntity] {
        do {
            let result = try context.fetch(LeagueEntity.fetchRequest())
            return result
        } catch let error {
            print("failed to fetch leagues from favoirte: \(error.localizedDescription)")
        }
        print("returning empty list")
        return []
    }
    
    func insertLeague(league: LeagueView) {
        let entity = LeagueEntity(context: self.context)
        entity.leaugeId = "\(league.id)"
        entity.leagueName = league.name
        entity.leagueImageUrl = league.logoUrl
        entity.sportId = league.sportId
        
        do {
            try context.save()
        } catch let error {
            print("failed to save \(league.name)")
            print("with error: \(error.localizedDescription)")
        }
    }
    
    func deleteLeauge(league: LeagueView) {
        
        // Create a fetch request to find the specific LeagueEntity to delete
         let fetchRequest: NSFetchRequest<LeagueEntity> = LeagueEntity.fetchRequest()
         fetchRequest.predicate = NSPredicate(format: "leaugeId == %@ AND leagueName == %@ AND leagueImageUrl == %@ AND sportId == %@", "\(league.id)", league.name, league.logoUrl, league.sportId)
         do {
             let results = try context.fetch(fetchRequest)
             if let leagueToDelete = results.first {
                 context.delete(leagueToDelete)
                 print("deleted \(league.name)")
                 try context.save()
                 print("committed changes for delete")
             } else {
                 print("Could not find league with matching details to delete: \(league)")
             }
         } catch let error {
             print("failed to delete \(league.name)")
             print("with error: \(error.localizedDescription)")
         }
    }
}
    
    
    

