//
//  MeasurementStats.swift
//  
//
//  Created by Michael Schlicker on 22.03.20.
//

import Fluent
import Vapor

struct MeasurementStats: Content {
    let maxTemperature: Int
    let minTemperature: Int
    let avgTemperature: Double
    let measurmentCount: Int

    init(measurements: [Measurement]) {
        let temperatures = measurements.map { $0.temperature }
        maxTemperature = temperatures.max() ?? 0
        minTemperature = temperatures.min() ?? 0
        measurmentCount = temperatures.count
        avgTemperature = measurmentCount != 0 ? Double(temperatures.reduce(0, +)) / Double(measurmentCount) : 0.0
    }
}
