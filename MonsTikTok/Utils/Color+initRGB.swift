import SwiftUI

extension Color {
    @MainActor public init(r red: Int, g green: Int, b blue: Int) {
        self = Color(red: Double(red) / 255.0, green: Double(green) / 255.0, blue: Double(blue) / 255.0, opacity: 1)
    }
    
    @MainActor public init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hex)
        if hex.hasPrefix("#") {
            scanner.currentIndex = scanner.string.index(after: scanner.currentIndex)
        }
        
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = Double((rgbValue & 0xff0000) >> 16) / 255
        let g = Double((rgbValue & 0x00ff00) >> 8) / 255
        let b = Double(rgbValue & 0x0000ff) / 255
        
        self.init(red: r, green: g, blue: b)
    }
}
