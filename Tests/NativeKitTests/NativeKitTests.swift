import XCTest
@testable import NativeKit

final class NativeKitTests: XCTestCase {
  func testRedRGBA() throws {
      let red: NativeColor = .red
      let (r, g, b, a) = red.rgba
      XCTAssertEqual(r, 1)
      XCTAssertEqual(g, 0)
      XCTAssertEqual(b, 0)
      XCTAssertEqual(a, 1)

      let (rd, gd, bd, ad) = red.rgbaData
      XCTAssertEqual(rd, 255)
      XCTAssertEqual(gd, 0)
      XCTAssertEqual(bd, 0)
      XCTAssertEqual(ad, 255)
  }

    func testGrayRGBA() throws {
        let gray: NativeColor = .init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let (r, g, b, a) = gray.rgba
        XCTAssertEqual(r, 0.5)
        XCTAssertEqual(g, 0.5)
        XCTAssertEqual(b, 0.5)
        XCTAssertEqual(a, 0.5)

        let (rd, gd, bd, ad) = gray.rgbaData
        XCTAssertEqual(rd, 127)
        XCTAssertEqual(gd, 127)
        XCTAssertEqual(bd, 127)
        XCTAssertEqual(ad, 127)
    }

    func testRedHSBA() throws {
        let red: NativeColor = .red
        let (h, s, b, a) = red.hsba
        XCTAssertEqual(h, 0)
        XCTAssertEqual(s, 1)
        XCTAssertEqual(b, 1)
        XCTAssertEqual(a, 1)
    }

    func testBlueishHSBA() throws {
        let ch: NativeColor = .init(hue: 0.2, saturation: 0.3, brightness: 0.4, alpha: 0.5)
        XCTAssertEqual(ch.hsba.hue, 0.2, accuracy: 0.01)
        XCTAssertEqual(ch.hsba.saturation, 0.3, accuracy: 0.01)
        XCTAssertEqual(ch.hsba.brightness, 0.4, accuracy: 0.01)
        XCTAssertEqual(ch.hsba.alpha, 0.5, accuracy: 0.01)
        let cr: NativeColor = .init(red: ch.rgba.red, green: ch.rgba.green, blue: ch.rgba.blue, alpha: ch.rgba.alpha)
        XCTAssertEqual(cr.hsba.hue, 0.2, accuracy: 0.01)
        XCTAssertEqual(cr.hsba.saturation, 0.3, accuracy: 0.01)
        XCTAssertEqual(cr.hsba.brightness, 0.4, accuracy: 0.01)
        XCTAssertEqual(cr.hsba.alpha, 0.5, accuracy: 0.01)
    }

      func testGrayHSBA() throws {
          let gray: NativeColor = .init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
          let (h, s, b, a) = gray.hsba
          XCTAssertEqual(h, 0)
          XCTAssertEqual(s, 0)
          XCTAssertEqual(b, 0.5)
          XCTAssertEqual(a, 0.5)
      }
}
