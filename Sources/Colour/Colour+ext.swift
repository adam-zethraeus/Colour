import NativeKit
import CoreGraphics

extension Colour {

    // MARK: Public

    /// Red, Green, Blue, Alpha
    public var rgbaData: (red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8) {
        nativeColor.rgbaData
    }

    /// Red, Green, Blue, Alpha
    public var rgba: (red: Double, green: Double, blue: Double, alpha: Double) {
        nativeColor.rgba
    }

    /// Hue, Saturation, Brightness, Alpha
    public var hsba: (hue: Double, saturation: Double, brightness: Double, alpha: Double) {
        nativeColor.hsba
    }

    // MARK: Internal

    var cmyka: (cyan: Double, magenta: Double, yellow: Double, black: Double, alpha: Double) {
        nativeColor.cmyka
    }

}

// MARK: - static colours
extension Colour {

    /// macOS light-mode ('Aqua') red.  (RGBA hex: `#ff3b2fff`)
    public static let red = Colour(#colorLiteral(red: 1.0, green: 0.233, blue: 0.186, alpha: 1.0))

    /// macOS light-mode ('Aqua') orange.  (RGBA hex: `#ff9500ff`)
    public static let orange = Colour(#colorLiteral(red: 1.0, green: 0.584, blue: 0.0, alpha: 1.0))

    /// macOS light-mode ('Aqua') yellow.  (RGBA hex: `#ffcc02ff`)
    public static let yellow = Colour(#colorLiteral(red: 1.0, green: 0.8, blue: 0.008, alpha: 1.0))

    /// macOS light-mode ('Aqua') green.  (RGBA hex: `#27cd41ff`)
    public static let green = Colour(#colorLiteral(red: 0.153, green: 0.804, blue: 0.255, alpha: 1.0))

    /// macOS light-mode ('Aqua') mint.  (RGBA hex: `#03c7beff`)
    public static let mint = Colour(#colorLiteral(red: 0.012, green: 0.78, blue: 0.745, alpha: 1.0))

    /// macOS light-mode ('Aqua') teal.  (RGBA hex: `#59adc4ff`)
    public static let teal = Colour(#colorLiteral(red: 0.349, green: 0.678, blue: 0.769, alpha: 1.0))

    /// macOS light-mode ('Aqua') cyan.  (RGBA hex: `#54bef0ff`)
    public static let cyan = Colour(#colorLiteral(red: 0.329, green: 0.745, blue: 0.941, alpha: 1.0))

    /// macOS light-mode ('Aqua') blue.  (RGBA hex: `#007affff`)
    public static let blue = Colour(#colorLiteral(red: 0.0, green: 0.478, blue: 1.0, alpha: 1.0))

    /// macOS light-mode ('Aqua') indigo.  (RGBA hex: `#5856d5ff`)
    public static let indigo = Colour(#colorLiteral(red: 0.345, green: 0.337, blue: 0.835, alpha: 1.0))

    /// macOS light-mode ('Aqua') purple.  (RGBA hex: `#af52deff`)
    public static let purple = Colour(#colorLiteral(red: 0.686, green: 0.322, blue: 0.871, alpha: 1.0))

    /// macOS light-mode ('Aqua') pink.  (RGBA hex: `#ff2c55ff`)
    public static let pink = Colour(#colorLiteral(red: 1.0, green: 0.173, blue: 0.333, alpha: 1.0))

    /// Apple color picker magenta.  (RGBA hex: `#ff42ffff`)
    public static let magenta = Colour(#colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1))

    /// macOS light-mode ('Aqua') brown.  (RGBA hex: `#a2845eff`)
    public static let brown = Colour(#colorLiteral(red: 0.635, green: 0.518, blue: 0.369, alpha: 1.0))

    /// macOS light-mode ('Aqua') grey.  (RGBA hex: `#8e8e93ff`)
    public static let grey = Colour(#colorLiteral(red: 0.557, green: 0.557, blue: 0.576, alpha: 1.0))

    /// macOS light-mode ('Aqua') white.  (RGBA hex: `#efefefff`)
    public static let white = Colour(#colorLiteral(red: 0.937, green: 0.937, blue: 0.937, alpha: 1.0))

    /// macOS light-mode ('Aqua') black.  (RGBA hex: `#000000ff`)
    public static let black = Colour(#colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0))

    /// macOS light-mode ('Aqua') clear.  (RGBA hex: `#ffffff00`)
    public static let clear = Colour(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0))

}
