import CoreGraphics
import NativeKit
import SwiftUI

public enum ColourSpace {
    case displayP3
    case sRGB
    
    var name: String {
        switch self {
        case .displayP3: "extended"
        case .sRGB: "rgb"
        }
    }

    var cgColorSpace: CGColorSpace? {
        switch self {
        case .displayP3:
            CGColorSpace(
                name: CGColorSpace.displayP3
            )
        case .sRGB:
            CGColorSpace(
                name: CGColorSpace.sRGB
            )
        }
    }
}

struct HueSaturation: Equatable {
    let hue: CGFloat
    let saturation: CGFloat
}

struct SpacialHueSaturation: Equatable {
    let hueSaturation: HueSaturation
    var hue: CGFloat { hueSaturation.hue }
    var saturation: CGFloat { hueSaturation.saturation }
    let colourSpace: ColourSpace
}

struct Colour: Equatable {
    let spacialHueSaturation: SpacialHueSaturation
    var colorSpace: ColourSpace { spacialHueSaturation.colourSpace }
    var hue: CGFloat { spacialHueSaturation.hue }
    var saturation: CGFloat { spacialHueSaturation.saturation }
    let brightness: CGFloat
    let alpha: CGFloat
}

extension Color {
    var cgColorResolved: CGColor? {
        if #available(iOS 17, *) {
            resolve(in: .init()).cgColor
        } else {
            cgColor
        }
    }
}

extension Colour {

    init?(
        _ color: Color,
        alpha: CGFloat = 1,
        colourSpace: ColourSpace = .sRGB
    ) {
        guard let cgColor: CGColor = color.cgColorResolved,
              let space = colourSpace.cgColorSpace,
              let converted = cgColor.converted(
                  to: space,
                  intent: .defaultIntent,
                  options: nil
              ),
              let components: [CGFloat] = converted.components
        else {
            return nil
        }

        let red: CGFloat = components[0]
        let green: CGFloat = components[1]
        let blue: CGFloat = components[2]

        let (h,s,b,_) = NativeColor(
            red: red,
            green: green,
            blue: blue,
            alpha: 1
        ).hsba
        self.init(
            spacialHueSaturation: .init(
                hueSaturation: .init(
                    hue: h,
                    saturation: s
                ),
                colourSpace: colourSpace
            ),
            brightness: b,
            alpha: alpha
        )
    }

    init?(
        _ color: NativeColor,
        alpha: CGFloat = 1,
        colourSpace: ColourSpace = .sRGB
    ) {
        guard let space = colourSpace.cgColorSpace
        else {
            return nil
        }
        let converted = color
            .cgColor
            .converted(
                to: space,
                intent: .defaultIntent,
                options: nil
            )!
        let components: [CGFloat] = converted.components!

        let red: CGFloat = components[0]
        let green: CGFloat = components[1]
        let blue: CGFloat = components[2]

        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0

        NativeColor(
            red: red,
            green: green,
            blue: blue,
            alpha: 1
        ).getHue(
            &h,
            saturation: &s,
            brightness: &b,
            alpha: nil
        )
        self.init(
            spacialHueSaturation: .init(
                hueSaturation: .init(
                    hue: h,
                    saturation: s
                ),
                colourSpace: colourSpace
            ),
            brightness: b,
            alpha: alpha
        )
    }

    var hueSaturation: HueSaturation {
        .init(hue: hue, saturation: saturation)
    }

    private var sRGB: NativeColor {
        NativeColor(
            hue: hue,
            saturation: saturation,
            brightness: brightness,
            alpha: 1
        )
    }

    private var displayP3: NativeColor {
        let uint8Max = CGFloat(UInt8.max)
        let rgb = self.sRGB
        let (r,g,b,_) = rgb.rgbaData
        return NativeColor(
            displayP3Red: CGFloat(r) / uint8Max,
            green: CGFloat(g) / uint8Max,
            blue: CGFloat(b) / uint8Max,
            alpha: 1
        )
    }
}
extension Colour {

    var nativeColor: NativeColor {
        .init(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    var adjustedColor: NativeColor {
        switch colorSpace {
        case .displayP3:
            return displayP3
        case .sRGB:
            return sRGB
        }
    }
}

extension HueSaturation {
    func inColourSpace(_ colourSpace: ColourSpace) -> SpacialHueSaturation {
        SpacialHueSaturation(hueSaturation: self, colourSpace: colourSpace)
    }
}

extension SpacialHueSaturation {
    func with(brightness: CGFloat, alpha: CGFloat = 1) -> Colour {
        Colour(spacialHueSaturation: self, brightness: brightness, alpha: alpha)
    }
}
