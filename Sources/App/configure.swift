import Fluent
import FluentSQLiteDriver
import Vapor

// Called before your application initializes.
public func configure(_ app: Application) throws {
    // Serves files from `Public/` directory
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // Configure SQLite database
    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)
//    app.middleware.use(<#T##middleware: Middleware##Middleware#>)

    // Configure migrations
    app.migrations.add(CreateMeasurement())
    app.migrations.add(CreateThermostat())

    let exampleThermostat1 = Thermostat()
    exampleThermostat1.isSmartThermostat = true
    exampleThermostat1.name = "neu"
    exampleThermostat1.save(on: app.db).whenComplete {
        print($0)
    }

    let exampleThermostat2 = Thermostat()
    exampleThermostat2.isSmartThermostat = false
    exampleThermostat2.name = "alt"
    exampleThermostat2.save(on: app.db).whenComplete {
        print($0)
    }

    
    try routes(app)
}
