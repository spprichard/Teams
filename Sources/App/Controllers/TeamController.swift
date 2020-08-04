import Vapor
import Foundation
import MLBScrapperLib

struct TeamController {
    func getAllHandler(_ req: Request) throws -> EventLoopFuture<[TeamModel]> {
        return TeamModel.query(on: req.db).all()
    }
    
    func hydrateHandler(_ req: Request) throws -> EventLoopFuture<[TeamModel]> {
        let data = try req.content.decode(HydrateRequest.self)
        let teams = try Team.GetTeams(season: data.year)
        
        let models = teams.map { team -> TeamModel in
            guard let id = team.id else { fatalError() }
            
            return TeamModel(
                teamID: id,
                venueID: team.VenueID,
                venueName: team.VenueName,
                name: team.Name,
                divisionID: team.DivisionID
            )
        }
        
        return models
            .create(on: req.db)
            .flatMap { req.eventLoop.makeSucceededFuture(models) }
    }
}

extension TeamController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.get("api", "teams", use: getAllHandler)
        routes.post("api", "teams", use: hydrateHandler)
    }
}
