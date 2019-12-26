//
//  TeamController.swift
//  
//
//  Created by Steven Prichard on 12/24/19.
//

import Foundation
import Vapor
import MLBScrapperLib

struct TeamController: RouteCollection {
    func boot(router: Router) throws {
        router.get("api", "teams", use: getAllHandler)
        router.post("api", "teams", use: hydrateHandler)
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[Team]> {
        return Team.query(on: req).all()
    }
    
    func hydrateHandler(_ req: Request) throws -> Future<[Team]> {
        return try req
            .content
            .decode(HydrateRequest.self)
            .flatMap(to: [Team].self, ({ hydrate in
                let teamList = try Team.GetTeams(season: hydrate.year)
                return teamList
                    .map({ $0.create(on: req) })
                    .flatten(on: req)
            }))
            .catchMap({ error in
                throw Abort(.internalServerError, reason: "\(error)")
            })
    }
}
