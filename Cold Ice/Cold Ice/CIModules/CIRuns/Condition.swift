struct Condition: Codable, Identifiable {
    let id = UUID()
    var temperature: String
    var snowType: SnowType
    var wind: WindType
    var visibylity: VisibilityType
}