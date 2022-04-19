import Foundation

extension Double {
    static let twoFractionDigits: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "eur"
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    var formatted: String {
        return Double.twoFractionDigits.string(for: self) ?? ""
    }
}
