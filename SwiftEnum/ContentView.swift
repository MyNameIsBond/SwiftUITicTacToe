
enum Positions: CaseIterable {
  case upLeft, upCenter, upRight
  case middleLeft, middleCenter, middleRight
  case botLeft, botCenter, botRight
}

enum PlayersTurn {
  case playerOne, playerTwo
}

enum Sign: String {
  case circle = "🅾️"
  case x = "❎"
}

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
