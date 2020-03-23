//
//  Measurement.swift
//  
//
//  Created by Michael Schlicker on 22.03.20.
//

import Fluent
import Vapor

final class Measurement: Model, Content {

    static let schema = "measurement"

    @ID()
    var id: UUID?

    @Field(key: "timestamp")
    var timestamp: Int

    @Field(key: "temperature")
    var temperature: Int

    @Field(key: "thermostatId")
    var thermostatId: String

//    @Parent(key: "thermostat")
//    var thermostat: Thermostat
}

struct Measurements: Content {
    let measurements: [Measurement]
}
