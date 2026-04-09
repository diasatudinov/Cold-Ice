struct RideStyle: Codable, Identifiable {
    let id = UUID()
    var equipment: EquipmentType
    var rideStyle: RideType
}