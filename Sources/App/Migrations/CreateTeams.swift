import Foundation
import Fluent

struct CreateTeam: Migration {
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(TeamModel.schema)
            .delete()
    }
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(TeamModel.schema)
            .id()
            .field(TeamModel.FieldKeys.teamID, .int)
            .field(TeamModel.FieldKeys.venueID, .int)
            .field(TeamModel.FieldKeys.venueName, .string)
            .field(TeamModel.FieldKeys.name, .string)
            .field(TeamModel.FieldKeys.divisionID, .int)
            .unique(on: TeamModel.FieldKeys.name)
            .create()
    }
}
