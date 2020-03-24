import GRPCVapor
import Foundation

extension _Measurement: GRPCMessage {
    typealias ModelType = Measurement

    init(modelObject: Measurement) {
        var message = _Measurement()
        message.temperature = Int64(modelObject.temperature)
        message.thermostatID = modelObject.thermostatId
        message.idOptional = modelObject.id?.uuidString != nil ?
            _Measurement.OneOf_IDOptional.id(modelObject.id!.uuidString) :
            _Measurement.OneOf_IDOptional.noID(_Nil())
        //modelObject.id.map { _Measurement.OneOf_ID_OPTIONAL.id(UUID($0)) } ?? _Measurement.OneOf_ID_OPTIONAL.noID(_Nil())
        message.timestamp = Int64(modelObject.timestamp)
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
