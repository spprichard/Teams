import Vapor
import Fluent
import MLBScrapperLib
import FluentPostgresDriver



/// Called before your application initializes.
public func configure(_ app: Application) throws {
    // Register middleware
    app.middleware.use(ErrorMiddleware.default(environment: app.environment))

    let db = DBConfig(from: app.environment)
    
    app.databases.use(.postgres(
        hostname: db.host,
        username: db.user,
        password: db.password,
        database: db.name
    ), as: .psql)
    
    
    app.migrations.add(CreateTeam())
    try app.autoMigrate().wait()
    
    // register routes
    try routes(app)
}
