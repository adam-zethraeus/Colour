import NativeKit

struct HSBA {

    // MARK: Lifecycle

    init(
        hsba: (
            hue: Double,
            saturation: Double,
            brightness: Double,
            alpha: Double
        )
    ) {
        self.hue = hsba.hue
        self.saturation = hsba.saturation
        self.brightness = hsba.brightness
        self.alpha = hsba.alpha
    }

    // MARK: Internal

    let hue: Double
    let saturation: Double
    let brightness: Double
    let alpha: Double

    var h: Double { hue }
    var s: Double { saturation }
    var b: Double { brightness }
    var a: Double { alpha }

    var rgba: RGBA {
        RGBA(
            rgba: NativeColor(
                hue: hue,
                saturation: saturation,
                brightness: brightness,
                alpha: alpha
            ).rgba
        )
    }
}
