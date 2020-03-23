import Fluent

struct CreateMeasurement: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("measurement")
            .id()
            .field("timestamp", .int, .required)
            .field("temperature", .int, .required)
            .field("thermostatId", .int, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("measurement").delete()
    }
}

struct CreateThermostat: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("thermostat")
            .id()
            .field("name", .string)
            .field("isSmartThermostat", .bool, .required)
//            .foreignKey("measurements", references: "measurements", "id")
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("thermostat").delete()
    }
}
