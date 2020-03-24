import GRPCVapor

extension _Empty: GRPCMessage {
    typealias ModelType = Empty

    init(modelObject: Empty) {
        var message = _Empty()
    }

    func toModel() -> Empty {
        var object = Empty()
        return object
    }
}
