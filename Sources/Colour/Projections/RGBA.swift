import CoreFoundation
import NativeKit

struct RGBA {

    // MARK: Lifecycle

    init(RGBAHex: UInt32) {
        let red = Double((RGBAHex & 0xFF00_0000) >> 24) / 255.0
        let green = Double((RGBAHex & 0xFF0000) >> 16) / 255.0
        let blue = Double((RGBAHex & 0xFF00) >> 8) / 255.0
        let alpha = Double((RGBAHex & 0xFF) >> 0) / 255.0
        self.init(rgba: (red, green, blue, alpha))
    }

    init(RGBHex: UInt32, alpha: Double = 1.0) {
        let red = Double((RGBHex & 0xFF0000) >> 16) / 255.0
        let green = Double((RGBHex & 0xFF00) >> 8) / 255.0
        let blue = Double((RGBHex & 0xFF) >> 0) / 255.0
        self.init(rgba: (red, green, blue, alpha))
    }

    init?(hex: String) {
        let r, g, b, a: Double
        var hex = hex.lowercased()
        if hex.hasPrefix("#") {
            hex.removeFirst()
        }
        let regex = /[a-f0-9]*/
        guard
            let match = hex.wholeMatch(of: regex),
            !match.isEmpty
        else {
            return nil
        }
        if hex.count == 6 {
            let r0 = hex.index(hex.startIndex, offsetBy: 0)
            let r1 = hex.index(hex.startIndex, offsetBy: 2)
            let g0 = hex.index(hex.startIndex, offsetBy: 2)
            let g1 = hex.index(hex.startIndex, offsetBy: 4)
            let b0 = hex.index(hex.startIndex, offsetBy: 4)
            let b1 = hex.index(hex.startIndex, offsetBy: 6)
            guard
                let red = UInt8(hex[r0 ..< r1], radix: 16).map(Double.init),
                let green = UInt8(hex[g0 ..< g1], radix: 16).map(Double.init),
                let blue = UInt8(hex[b0 ..< b1], radix: 16).map(Double.init)
            else {
                return nil
            }
            r = red / 255.0
            g = green / 255.0
            b = blue / 255.0
            a = 1.0
        } else if hex.count == 8 {
            let r0 = hex.index(hex.startIndex, offsetBy: 0)
            let r1 = hex.index(hex.startIndex, offsetBy: 2)
            let g0 = hex.index(hex.startIndex, offsetBy: 2)
            let g1 = hex.index(hex.startIndex, offsetBy: 4)
            let b0 = hex.index(hex.startIndex, offsetBy: 4)
            let b1 = hex.index(hex.startIndex, offsetBy: 6)
            let a0 = hex.index(hex.startIndex, offsetBy: 6)
            let a1 = hex.index(hex.startIndex, offsetBy: 8)
            guard
                let red = UInt8(hex[r0 ..< r1], radix: 16).map(Double.init),
                let green = UInt8(hex[g0 ..< g1], radix: 16).map(Double.init),
                let blue = UInt8(hex[b0 ..< b1], radix: 16).map(Double.init),
                let alpha = UInt8(hex[a0 ..< a1], radix: 16).map(Double.init)
            else {
                return nil
            }
            r = red / 255.0
            g = green / 255.0
            b = blue / 255.0
            a = alpha / 255.0
        } else {
            return nil
        }
        self.init(rgba: (r, g, b, a))
    }

    init?(_ description: String) {
        let regex = /RGBA\(([0-9\.])*\, ([0-9\.])*\, ([0-9\.])*\, ([0-9\.])*\)/
        guard
            let match = description.wholeMatch(of: regex),
            let red = match.output.1.flatMap({ Double($0) }),
            let green = match.output.2.flatMap({ Double($0) }),
            let blue = match.output.3.flatMap({ Double($0) }),
            let alpha = match.output.4.flatMap({ Double($0) })
        else {
            return nil
        }
        self.init(rgba: (red, green, blue, alpha))
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let description = try container.decode(String.self)
        guard let this = RGBA(description)
        else {
            throw DecodingError.dataCorrupted(
                .init(
                    codingPath: [],
                    debugDescription: "Invalid RGBA value: \(description)"
                )
            )
        }
        self = this
    }

    init(
        rgba: (
            red: Double,
            green: Double,
            blue: Double,
            alpha: Double
        )
    ) {
        self.red = rgba.red.clamped
        self.blue = rgba.blue.clamped
        self.green = rgba.green.clamped
        self.alpha = rgba.alpha.clamped
    }

    // MARK: Internal

    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double

    var hexString: String {
        [red, green, blue, alpha]
            .map { channelProportion in
                String(
                    format: "%02lx",
                    Int((channelProportion * 255.0).rounded())
                )
            }
            .reduce("#", +)
    }

    var r: Double { red }
    var g: Double { green }
    var b: Double { blue }
    var a: Double { alpha }

    var nativeColor: NativeColor {
        NativeColor(red: red, green: green, blue: blue, alpha: alpha)
    }

}
