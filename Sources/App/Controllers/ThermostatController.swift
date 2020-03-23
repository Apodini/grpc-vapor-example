import Fluent
import Vapor

struct ThermostatController {

    func getThermostatIds(req: Request) -> EventLoopFuture<[String]> {
        return Thermostat
            .query(on: req.db)
            .all()
            .map { thermostats in
                thermostats.compactMap { $0.id?.uuidString }
            }
    }

    func getThermostatWithId(req: Request) throws -> EventLoopFuture<Thermostat> {
        return Thermostat
            .find(req.parameters.get("id"), on: req.db)
            .unwrap(or: ThermostatError.noThermostatWithId)
    }

    func getMeasurements(req: Request) throws -> EventLoopFuture<[Measurement]> {
        guard let thermostatId = req.parameters.get("id") else {
            return req.eventLoop.makeSucceededFuture([])
        }
        return Measurement.query(on: req.application.db)
            .filter("thermostatId", .equality(inverse: false), thermostatId)
            .all()
    }

    func uploadMeasurement(req: Request) throws -> EventLoopFuture<Measurement> {
        let measurement = try req.content.decode(Measurement.self)

        return measurement.save(on: req.db)
            .map { _ in measurement }
    }

    func calculateStatistics(req: Request) throws -> EventLoopFuture<MeasurementStats> {
        let measurements = try req.content.decode(Measurements.self)
        let statistics = MeasurementStats(measurements: measurements.measurements)
        return req.eventLoop.makeSucceededFuture(statistics)
    }
}

enum ThermostatError: Error {
    case noThermostatWithId
}
