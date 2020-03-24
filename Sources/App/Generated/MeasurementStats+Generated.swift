import GRPCVapor

extension _MeasurementStats: GRPCMessage {
    typealias ModelType = MeasurementStats

    init(modelObject: MeasurementStats) {
        var message = _MeasurementStats()
        message.avgTemperature = modelObject.avgTemperature
        message.minTemperature = Int64(modelObject.minTemperature)
        message.maxTemperature = Int64(modelObject.maxTemperature)
        message.measurmentCount = Int64(modelObject.measurmentCount)
    }

    func toModel() -> MeasurementStats {
        var object = MeasurementStats()
        object.avgTemperature = avgTemperature
        object.minTemperature = Int(minTemperature)
        object.maxTemperature = Int(maxTemperature)
        object.measurmentCount = Int(measurmentCount)
        return object
    }
}
