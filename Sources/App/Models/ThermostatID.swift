//
//  ThermostatID.swift
//  
//
//  Created by Michael Schlicker on 23.03.20.
//

import GRPCVapor

struct ThermostatID: GRPCModel {
    init() {
        id = ""
    }

    init(id: String) {
        self.id = id
    }

    var id: String
}

struct Empty: GRPCModel {}
