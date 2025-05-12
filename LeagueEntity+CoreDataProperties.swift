//
//  LeagueEntity+CoreDataProperties.swift
//  SportsProject
//
//  Created by Macos on 12/05/2025.
//
//

import Foundation
import CoreData


extension LeagueEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LeagueEntity> {
        return NSFetchRequest<LeagueEntity>(entityName: "LeagueEntity")
    }

    @NSManaged public var leaugeId: String?
    @NSManaged public var leagueName: String?
    @NSManaged public var leagueImageUrl: String?
    @NSManaged public var sportId: String?

}

extension LeagueEntity : Identifiable {

}
