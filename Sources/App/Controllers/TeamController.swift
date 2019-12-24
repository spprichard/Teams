//
//  File.swift
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
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[Team]> {
        return Team.query(on: req).all()
    }
}
