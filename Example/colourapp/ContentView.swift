import Colour
import SwiftUI

struct ContentView: View {
    @State var colourSpace = ColourSpace.sRGB
  var body: some View {
      ZStack {
          GeometryReader { proxy in
              if let img = ColourWheel(
                containerRect: .init(origin: .zero, size: proxy.size)
              ).colorWheel(space: colourSpace) {
                  Image(
                    img,
                    scale: 1,
                    label: Text("")
                  )
              }
          }.onTapGesture {
              colourSpace = colourSpace == .sRGB ? .displayP3 : .sRGB
          }
          Text(colourSpace == .sRGB ? "rgb" : "extended")
              .font(.title)
      }
  }
}

#Preview {
  ContentView()
}
