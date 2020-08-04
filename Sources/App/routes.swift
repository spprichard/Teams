import Vapor

/// Register your application's routes here.
public func routes(_ app: Application) throws {
    // Basic "It works" example
    app.get { req in
        return "It works!"
    }
    
    let tc = TeamController()
    try app.register(collection: tc)
}
