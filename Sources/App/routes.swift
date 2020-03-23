import Fluent
import Vapor

func routes(_ app: Application) throws {
    let thermostatController = ThermostatController()
    app.get("thermostatIds", use: thermostatController.getThermostatIds)
    app.get("thermostat", ":id", use: thermostatController.getThermostatWithId)
    app.get("measurements", ":id", use: thermostatController.getMeasurements)
    app.post("measurement", use: thermostatController.uploadMeasurement)
    app.post("measurementStats", use: thermostatController.calculateStatistics)
}
