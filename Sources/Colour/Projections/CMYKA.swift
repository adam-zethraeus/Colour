struct CMYKA {

    // MARK: Lifecycle

    init(
        cmyka: (
            cyan: Double,
            magenta: Double,
            yellow: Double,
            black: Double,
            alpha: Double
        )
    ) {
        self.cyan = cmyka.cyan.clamped
        self.magenta = cmyka.magenta.clamped
        self.yellow = cmyka.yellow.clamped
        self.black = cmyka.black.clamped
        self.alpha = cmyka.alpha.clamped
    }

    // MARK: Internal

    let cyan: Double
    let magenta: Double
    let yellow: Double
    let black: Double
    let alpha: Double

    var rgba: RGBA {
        let r = (1.0 - cyan) * (1.0 - black)
        let g = (1.0 - magenta) * (1.0 - black)
        let b = (1.0 - yellow) * (1.0 - black)
        return .init(rgba: (r, g, b, alpha))
    }

    var c: Double { cyan }
    var m: Double { magenta }
    var y: Double { yellow }
    var k: Double { black }
    var a: Double { alpha }
}
