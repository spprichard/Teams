import Vapor
import Foundation

struct DB {
    var host: String
    var user: String
    var password: String
    var name: String
    var port: Int
    
    static public func readFrom(env: Environment) -> DB? {
        guard let host = Environment.get("DB_HOST") else { return nil }
        guard let user = Environment.get("DB_USER") else { return nil }
        guard let password = Environment.get("DB_PASSWORD") else { return nil }
        guard let name = Environment.get("DB_NAME") else { return nil }
        guard let p = Environment.get("DB_PORT") else { return nil }
        guard let port = Int(p) else { return nil }
        
        return DB(
            host: host,
            user: user,
            password: password,
            name: name,
            port: port
        )
    }
}

func DBConfig(from env: Environment) -> DB {
    guard let db = DB.readFrom(env: env) else { fatalError() }
    return db
}

