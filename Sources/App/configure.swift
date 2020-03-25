import Fluent
import FluentSQLiteDriver
import Vapor
import GRPCVapor
import NIOSSL

// Called before your application initializes.
public func configure(_ app: Application) throws {
    // Serves files from `Public/` directory
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    let cert = try NIOSSLCertificate.fromPEMFile(FileManager.default.currentDirectoryPath + "/cert.pem")
    let keyPath = FileManager.default.currentDirectoryPath + "/key.pem"

    app.server.configuration.hostname = "localhost"

    // Comment these two lines to support REST requests
    app.server.configuration.supportVersions = [.two]
    app.server.configuration.tlsConfiguration = .forServer(certificateChain: cert.map { .certificate($0) }, privateKey: .file(keyPath))

    // Configure SQLite database
    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)
    app.middleware.use(GRPCMiddleware(services: [ThermostatService()]))
    app.autoMigrate()

    // Configure migrations
    app.migrations.add(CreateMeasurement())
    app.migrations.add(CreateThermostat())

    let exampleThermostat1 = Thermostat()
    exampleThermostat1.isSmartThermostat = true
    exampleThermostat1.name = "Thermostat Kitchen"
    exampleThermostat1.save(on: app.db).whenComplete {
        print($0)
    }

    let exampleThermostat2 = Thermostat()
    exampleThermostat2.isSmartThermostat = false
    exampleThermostat2.name = "Thermostat Living Room"
    exampleThermostat2.save(on: app.db).whenComplete {
        print($0)
    }

    try routes(app)
}
