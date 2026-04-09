//
//  Trick.swift
//  Cold Ice
//
//

import SwiftUI

struct Trick: Codable, Identifiable, Hashable {
    let id = UUID()
    var name: String
    var category: TrickCategory
    var difficulty: Difficulty
    var description: String
    var status: TrickStatus
    var progress: Int = 0
    var success: Int = 0
    var notes: String
}

enum TrickStatus: String, Codable, CaseIterable, Hashable {
    case learning, mastered, dropped
    
    var text: String {
        switch self {
        case .learning:
            "Learning"
        case .mastered:
            "Mastered"
        case .dropped:
            "Dropped"
        }
    }
    
    var color: Color {
        switch self {
        case .learning:
                .learning
        case .mastered:
                .mastered
        case .dropped:
                .dropped
        }
    }
    
}

enum Difficulty: String, Codable, CaseIterable, Hashable {
    case one, two, three
    
    var image: String {
        switch self {
        case .one:
            "oneStarsCI"
        case .two:
            "twoStarsCI"
        case .three:
            "threeStarsCI"
        }
    }
}

enum TrickCategory: String, Codable, CaseIterable, Hashable {
    case spins, flips, butters, rails, ski, specific
    
    var text: String {
        switch self {
        case .spins:
            "Spins"
        case .flips:
            "Flips"
        case .butters:
            "Butters"
        case .rails:
            "Rails & Jumps"
        case .ski:
            "Ski Specific"
        case .specific:
            "Snowboard Specific"
        }
    }
}
