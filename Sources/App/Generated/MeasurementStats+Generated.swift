import GRPCVapor

extension _MeasurementStats: GRPCMessage {
    typealias ModelType = MeasurementStats

    init(modelObject: MeasurementStats) {
        avgTemperature = modelObject.avgTemperature
        minTemperature = Int64(modelObject.minTemperature)
        maxTemperature = Int64(modelObject.maxTemperature)
        measurmentCount = Int64(modelObject.measurmentCount)
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
