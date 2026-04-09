//
//  RideStyle.swift
//  Cold Ice
//
//

import SwiftUI

struct RideStyle: Codable, Identifiable, Hashable {
    let id = UUID()
    var equipment: EquipmentType
    var rideStyle: RideType
}

enum RideType: String, Codable, CaseIterable, Hashable {
    case park, freeride, piste, tricks
    
    var text: String {
        switch self {
        case .park:
            "Park"
        case .freeride:
            "Freeride"
        case .piste:
            "Piste"
        case .tricks:
            "Tricks"
        }
    }
}

enum EquipmentType: String, Codable, CaseIterable, Hashable {
    case ski, snowboard
    
    var text: String {
        switch self {
        case .ski:
            "Ski"
        case .snowboard:
            "Snowboard"
        }
    }
}
