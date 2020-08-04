import Vapor
import Fluent
import Foundation


final class TeamModel: Model {
    static var schema = "teams"
    
    struct FieldKeys {
        static var id: FieldKey { "id" }
        static var teamID: FieldKey { "team_id" }
        static var venueID: FieldKey { "venue_id" }
        static var venueName: FieldKey { "venue_name" }
        static var name: FieldKey { "name" }
        static var divisionID: FieldKey { "division_id" }
    }
    
    @ID()
    var id: UUID?
    
    @Field(key: FieldKeys.teamID)
    var teamID: Int
    
    @Field(key: FieldKeys.venueID)
    var venueID: Int
    
    @Field(key: FieldKeys.venueName)
    var venueName: String
    
    @Field(key: FieldKeys.name)
    var name: String
    
    @Field(key: FieldKeys.divisionID)
    var divisionID: Int
    
    init() {}
    
    init(id: UUID? = nil, teamID: Int, venueID: Int, venueName: String, name: String, divisionID: Int) {
        self.id = id
        self.teamID = teamID
        self.venueID = venueID
        self.venueName = venueName
        self.name = name
        self.divisionID = divisionID
    }
}

extension TeamModel: Content {}
