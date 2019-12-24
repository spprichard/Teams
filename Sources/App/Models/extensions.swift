//
//  File.swift
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
