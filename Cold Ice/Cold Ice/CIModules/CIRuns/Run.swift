//
//  Run.swift
//  Cold Ice
//
//

import SwiftUI

struct Run: Codable, Identifiable, Hashable {
    let id = UUID()
    var location: String
    var date: Date
    var time: Date
    var conditions: Condition
    var rideStyle: RideStyle
    var memories: String
    var equipment: [GearItem] = []
    
    var imageData: Data?
    
    var image: UIImage? {
        get {
            guard let imageData else { return nil }
            return UIImage(data: imageData)
        }
        set {
            imageData = newValue?.jpegData(compressionQuality: 0.8)
        }
    }
}
