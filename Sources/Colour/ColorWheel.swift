import CoreGraphics

public struct ColourWheel {
    public init(containerRect: CGRect) {
        self.containerRect = containerRect
    }

    let containerRect: CGRect
    private let center: CGFloat = 0.5
}

// MARK: - API

extension ColourWheel {

    func hueSaturation(atPoint position: CGPoint) -> HueSaturation? {
        let innerPoint = toNormalFromContainer(position: position)
        return hueSaturation(atNormal: innerPoint)
    }

    func position(for hueSaturation: HueSaturation) -> CGPoint {
        let position = innerPosition(for: hueSaturation)
        return invertToContainer(position: position)
    }

    public func colorWheel(space: ColourSpace) -> CGImage? {
        let size = containerRect.size
        let width = Int(size.width)
        let height = Int(size.height)
        let bufferSize: Int = width * height * 3
        let bitmapData: CFMutableData = CFDataCreateMutable(nil, 0)
        CFDataSetLength(bitmapData, CFIndex(bufferSize))
        guard let bitmap = CFDataGetMutableBytePtr(bitmapData) else { return nil }
        for y in stride(from: CGFloat(0), to: size.height, by: 1) {
            for x in stride(from: CGFloat(0), to: size.width, by: 1) {
                let hs = hueSaturation(atPoint: .init(x: x, y: y))
                let offset = (Int(x) + (Int(y) * width)) * 3
                if let colour = hs?
                    .inColourSpace(space)
                    .with(brightness: 1) {

                    let rgb = colour.rgbaData

                    bitmap[offset] = rgb.red
                    bitmap[offset + 1] = rgb.green
                    bitmap[offset + 2] = rgb.blue
                } else {
                    bitmap[offset] = 0
                    bitmap[offset + 1] = 0
                    bitmap[offset + 2] = 0
                }
            }
        }


        guard let colorSpace = space.cgColorSpace,
              let provider = CGDataProvider(data: bitmapData)
        else {
            return nil
        }
        return CGImage(
            width: width,
            height: height,
            bitsPerComponent: 8,
            bitsPerPixel: 24,
            bytesPerRow: width * 3,
            space: colorSpace,
            bitmapInfo: [],
            provider: provider,
            decode: nil,
            shouldInterpolate: false,
            intent: .defaultIntent
        )
    }

}

// MARK: - private implementation
extension ColourWheel {
    private var innerRect: CGRect {
        let interiorSize: CGFloat = min(
            containerRect.width,
            containerRect.height
        )
        return CGRect(
            x: (containerRect.width - interiorSize)/2,
            y: (containerRect.height - interiorSize)/2,
            width: interiorSize,
            height: interiorSize
        )
    }

    private func hueSaturation(atNormal normalizedPosition: CGPoint) -> HueSaturation? {
        let saturation = radius(at: normalizedPosition) * 2.0
        let hue = normalize(radian: -angle(at: normalizedPosition)) / (CGFloat.pi * 2.0)
        if hue < 0.0 || saturation < 0.0 || saturation > 1.0 {
            return nil
        }
        return HueSaturation(hue: hue, saturation: saturation)
    }

    private func innerPosition(for hueSaturation: HueSaturation) -> CGPoint {
        let radius = hueSaturation.saturation / 2
        let angle = hueSaturation.hue * (CGFloat.pi * -2)
        return CGPoint(
            x: (radius * cos(angle)) + center,
            y: (radius * sin(angle)) + center
        )
    }

    private func radius(at position: CGPoint) -> CGFloat {
        hypot(position.x - center, position.y - center)
    }

    private func angle(at position: CGPoint) -> CGFloat {
        atan2(position.y - center, position.x - center)
    }

    private func normalize(radian: CGFloat) -> CGFloat {
        let pi2 = CGFloat.pi * 2
        let reminder = radian.truncatingRemainder(dividingBy: pi2)
        return radian < 0.0 ? reminder + pi2 : reminder
    }

    private func toNormalFromContainer(position: CGPoint) -> CGPoint {
        let rect = innerRect
        return CGPoint(
            x: (position.x - rect.minX) / rect.width,
            y: (position.y - rect.minY) / rect.height
        )
    }

    private func invertToContainer(position: CGPoint) -> CGPoint {
        let rect = innerRect
        return CGPoint(
            x: rect.minX + rect.width * position.x,
            y: rect.minY + rect.height * position.y
        )
    }
 }
