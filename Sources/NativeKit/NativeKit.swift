#if canImport(UIKit)
import UIKit
public typealias NativeColor = UIColor
#elseif canImport(AppKit)
import AppKit
public typealias NativeColor = NSColor
#endif

extension NativeColor {
    public var rgba: (red: Double, green: Double, blue: Double, alpha: Double) {
        var redComponent: CGFloat = 0
        var greenComponent: CGFloat = 0
        var blueComponent: CGFloat = 0
        var alphaComponent: CGFloat = 0
        getRed(&redComponent, green: &greenComponent, blue: &blueComponent, alpha: &alphaComponent)
        return (
            red: redComponent,
            green: greenComponent,
            blue: blueComponent,
            alpha: alphaComponent
        )
    }

    public var rgbaData: (red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8) {
        let uInt8max = CGFloat(UInt8.max)
        var redComponent: CGFloat = 0
        var greenComponent: CGFloat = 0
        var blueComponent: CGFloat = 0
        var alphaComponent: CGFloat = 0
        getRed(&redComponent, green: &greenComponent, blue: &blueComponent, alpha: &alphaComponent)
        return (
            red: UInt8(redComponent * uInt8max),
            green: UInt8(greenComponent * uInt8max),
            blue: UInt8(blueComponent * uInt8max),
            alpha: UInt8(alphaComponent * uInt8max)
        )
    }

    public var hsba: (hue: Double, saturation: Double, brightness: Double, alpha: Double) {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (hue: h, saturation: s, brightness: b, alpha: a)
    }

    public var cmyka: (
        cyan: Double,
        magenta: Double,
        yellow: Double,
        black: Double,
        alpha: Double
    ) {
#if canImport(UIKit)
        let (r, g, b, a) = rgba
        let k = 1.0 - max(r, g, b)
        var c = (1.0 - r - k) / (1.0 - k)
        var m = (1.0 - g - k) / (1.0 - k)
        var y = (1.0 - b - k) / (1.0 - k)
        if c.isNaN {
            c = 0.0
        }
        if m.isNaN {
            m = 0.0
        }
        if y.isNaN {
            y = 0.0
        }
        return (cyan: c, magenta: m, yellow: y, black: k, alpha: a)
#elseif canImport(AppKit)
        var c: CGFloat = 0
        var m: CGFloat = 0
        var y: CGFloat = 0
        var k: CGFloat = 0
        var a: CGFloat = 0
        getCyan(&c, magenta: &m, yellow: &y, black: &k, alpha: &a)
        return (cyan: c, magenta: m, yellow: y, black: k, alpha: a)
#endif
    }
}
