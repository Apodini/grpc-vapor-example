//
//  Thermostat.swift
//  
//
//  Created by Michael Schlicker on 22.03.20.
//

import Fluent
import Vapor
import GRPCVapor

final class Thermostat: Model, Content, GRPCModel {

    static let schema = "thermostat"

    @ID()
    var id: UUID?

    @Field(key: "name")
    var name: String?

    @Field(key: "isSmartThermostat")
    var isSmartThermostat: Bool

//    @ChildrenProperty<Thermostat, Measurement>(for: \Measurement.$thermostat)
//    var measurements: [Measurement]
}
