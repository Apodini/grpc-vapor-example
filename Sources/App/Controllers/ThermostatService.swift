//
//  ThermostatService.swift
//  
//
//  Created by Michael Schlicker on 23.03.20.
//

import GRPCVapor
import Vapor
import Fluent

class ThermostatService: GRPCService {

    func getThermostatIds(request: GRPCServerStreamRequest<Empty, ThermostatID>) {
        Thermostat
            .query(on: request.vaporRequest.db)
            .all()
            .whenSuccess { thermostats in
                thermostats.forEach {
                    guard let id = $0.id?.uuidString else { return }
                    request.sendResponse(message: ThermostatID(id: id))
                }
                request.sendEnd()
            }
    }

    func getThermostatWithId(request: GRPCRequest<ThermostatID>) -> EventLoopFuture<Thermostat> {
        return Thermostat
            .find(UUID(uuidString: request.message.id), on: request.db)
            .unwrap(or: ThermostatError.noThermostatWithId)
    }

    func getMeasurements(req: GRPCServerStreamRequest<ThermostatID, Measurement>) {
        Measurement.query(on: req.vaporRequest.db)
            .filter("thermostatId", .equality(inverse: false), req.message.id)
            .all()
            .whenSuccess { measurements in
                measurements.forEach {
                    req.sendResponse(message: $0)
                }
                req.sendEnd()
            }
    }

    func uploadMeasurements(req: GRPCStreamRequest<Measurement, Measurement>) {
        req.forEach { measurement in
            measurement.save(on: req.vaporRequest.db)
                .whenSuccess { _ in req.sendResponse(message: measurement) }
            }
        .whenComplete { _ in req.sendEnd() }

    }

    func calculateStatistics(req: GRPCClientStreamRequest<Measurement>) -> EventLoopFuture<MeasurementStats> {
        return req.collect()
            .map { MeasurementStats(measurements: $0) }
    }

}
