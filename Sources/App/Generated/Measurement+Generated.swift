import GRPCVapor
import Foundation

extension _Measurement: GRPCMessage {
    typealias ModelType = Measurement

    init(modelObject: Measurement) {
        temperature = Int64(modelObject.temperature)
        thermostatID = modelObject.thermostatId
        idOptional = modelObject.id?.uuidString != nil ?
            _Measurement.OneOf_IDOptional.id(modelObject.id!.uuidString) :
            _Measurement.OneOf_IDOptional.noID(_Nil())
        timestamp = Int64(modelObject.timestamp)
    }

    func toModel() -> Measurement {
        var object = Measurement()
        object.temperature = Int(temperature)
        object.thermostatId = thermostatID
        object.id = idOptional.flatMap { optional in
            if case let .id(value) = optional {
                return UUID(uuidString: value)
            } else {
                return nil
            }
        }
        object.timestamp = Int(timestamp)
        return object
    }
}
