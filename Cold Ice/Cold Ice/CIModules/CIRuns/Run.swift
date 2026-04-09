struct Run: Codable, Identifiable {
    let id = UUID()
    var location: String
    var date: Date
    var time: Date
    var conditions: Condition
    var rideStyle: RideStyle
    var memories: String
    
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