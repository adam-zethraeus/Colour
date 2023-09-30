extension BinaryFloatingPoint {
    var clamped: Double { max(min(Double(self), 1.0), 0.0) }
}

extension Double {
    var decimal: String {
        String(format: "%.3f", self)
    }
}
