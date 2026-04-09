//
//  Condition.swift
//  Cold Ice
//
//

import SwiftUI

struct Condition: Codable, Identifiable, Hashable {
    let id = UUID()
    var temperature: String
    var snowType: SnowType
    var wind: WindType
    var visibylity: VisibilityType
}

enum SnowType: String, Codable, CaseIterable, Hashable {
    case powder, packed, ice, slush, artificial
    
    var text: String {
        switch self {
        case .powder:
            "Powder"
        case .packed:
            "Packed"
        case .ice:
            "Ice"
        case .slush:
            "Slush"
        case .artificial:
            "Artificial"
        }
    }
    
    var icon: UIImage {
        switch self {
        case .powder:
                .powderIconCI
        case .packed:
                .packedIconCI
        case .ice:
                .iceIconCI
        case .slush:
                .slushIconCI
        case .artificial:
                .artificialIconCI
        }
    }
}
enum WindType: String, Codable, CaseIterable, Hashable {
    case calm, light, medium, strong
    
    var text: String {
        switch self {
        case .calm:
            "Calm"
        case .light:
            "Light"
        case .medium:
            "Medium"
        case .strong:
            "Strong"
        }
    }
}

enum VisibilityType: String, Codable, CaseIterable, Hashable {
    case sunny, cloudy, fog, snowing
    
    var text: String {
        switch self {
        case .sunny:
            "Sunny"
        case .cloudy:
            "Cloudy"
        case .fog:
            "Fog"
        case .snowing:
            "Snowing"
        }
    }
}
