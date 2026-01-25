import SwiftUI

class AppSettings: ObservableObject {
    @AppStorage("displayPeriod") var displayPeriod: Double = 10.0
    @AppStorage("showMetadata") var showMetadata: Bool = true
    @AppStorage("transitionDuration") var transitionDuration: Double = 1.5

    static let shared = AppSettings()

    var displayPeriodRange: ClosedRange<Double> { 5.0...60.0 }
    var transitionDurationRange: ClosedRange<Double> { 0.5...3.0 }
}
