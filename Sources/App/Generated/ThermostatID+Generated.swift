import GRPCVapor

extension _ThermostatID: GRPCMessage {
    typealias ModelType = ThermostatID

    init(modelObject: ThermostatID) {
        id = modelObject.id
    }

    func toModel() -> ThermostatID {
        var object = ThermostatID()
        object.id = id
        return object
    }
}
