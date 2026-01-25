import Foundation

extension Numeric {
    func formattedNumber(
        maxFractionDigits: Int = 2
    ) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.decimalSeparator = "."
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = maxFractionDigits
        
        return formatter.string(for: self) ?? "\(self)"
    }
}

extension Numeric {
    @inline(__always) var nanoseconds: UInt64 {
        let value = Double("\(self)") ?? 0
        return UInt64(value * 1_000_000_000)
    }
}
