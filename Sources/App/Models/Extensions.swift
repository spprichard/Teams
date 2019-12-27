//
//  Extensions.swift
//  
//
//  Created by Steven Prichard on 12/24/19.
//

import Foundation
import Vapor
import FluentPostgreSQL
import MLBScrapperLib

extension Team: PostgreSQLModel {}
extension Team: Migration {}
extension Team: Content {}

extension Team: PostgreSQLMigration {
    public static func prepare(on conn: PostgreSQLConnection) -> EventLoopFuture<Void> {
        return PostgreSQLDatabase.create(Team.self, on: conn) { builder in
            builder.field(for: \.id, isIdentifier: true)
            builder.field(for: \.VenueID)
            builder.field(for: \.VenueName)
            builder.field(for: \.Name)
            builder.field(for: \.DivisionID)
        }
    }
    
    public static func revert(on connection: PostgreSQLConnection) -> EventLoopFuture<Void> {
        return PostgreSQLDatabase.delete(Team.self, on: connection)
    }
}
