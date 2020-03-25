import GRPCVapor
import Foundation

extension _Thermostat: GRPCMessage {
    typealias ModelType = Thermostat

    init(modelObject: Thermostat) {
        var message = _Thermostat()
        idOptional = modelObject.id.map { _Thermostat.OneOf_IDOptional.id($0.uuidString) } ??
            _Thermostat.OneOf_IDOptional.noID(_Nil())
        idOptional = modelObject.id?.uuidString != nil ?
            _Thermostat.OneOf_IDOptional.id(modelObject.id!.uuidString) :
            _Thermostat.OneOf_IDOptional.noID(_Nil())
                //= modelObject.id.map { _Thermostat.OneOf_ID_OPTIONAL.id(UUID($0)) } ?? _Thermostat.OneOf_ID_OPTIONAL.noID(_Nil())
        isSmartThermostat = modelObject.isSmartThermostat
        nameOptional = modelObject.name.map { _Thermostat.OneOf_NameOptional.name($0) } ??
            _Thermostat.OneOf_NameOptional.noName(_Nil())
    }

    func toModel() -> Thermostat {
        var object = Thermostat()
        object.id = idOptional.flatMap { optional in
            if case let .id(value) = optional {
                return UUID(uuidString: value)
            } else {
                return nil
            }
        }
        object.isSmartThermostat = isSmartThermostat
        object.name = nameOptional.flatMap { optional in
            if case let .name(value) = optional {
                return value
            } else {
                return nil
            }
        }
        return object
    }
}
