import FluentPostgreSQL
import MLBScrapperLib
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers first
    try services.register(FluentPostgreSQLProvider())

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    // Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    let dbConf = PostgreSQLDatabaseConfig(
        hostname: Environment.get("DATABASE_HOSTNAME") ?? "localhost",
        username: Environment.get("DATABASE_USER") ?? "vapor",
        database: Environment.get("DATABASE_DB") ?? "vapor",
        password: Environment.get("DATABASE_PASSWORD") ?? "password"
    )
    
    let db = PostgreSQLDatabase(config: dbConf)
    databases.add(database: db, as: .psql)
    services.register(databases)

    var migrations = MigrationConfig()
    migrations.add(model: Team.self, database: .psql)
    services.register(migrations)
}
