//
//  MeasurementStats.swift
//  
//
//  Created by Michael Schlicker on 22.03.20.
//

import Fluent
import Vapor
import GRPCVapor

struct MeasurementStats: Content, GRPCModel {
    init() {
        maxTemperature = 0
        minTemperature = 0
        avgTemperature = 0.0
        measurmentCount = 0
    }

    var maxTemperature: Int
    var minTemperature: Int
    var avgTemperature: Double
    var measurmentCount: Int

    init(measurements: [Measurement]) {
        let temperatures = measurements.map { $0.temperature }
        maxTemperature = temperatures.max() ?? 0
        minTemperature = temperatures.min() ?? 0
        measurmentCount = temperatures.count
        avgTemperature = measurmentCount != 0 ? Double(temperatures.reduce(0, +)) / Double(measurmentCount) : 0.0
    }
}
