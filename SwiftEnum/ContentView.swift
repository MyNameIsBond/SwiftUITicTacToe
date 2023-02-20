
import SwiftUI

enum Positions: CaseIterable {
  case upLeft, upCenter, upRight
  case midleLeft, midleCenter, midleRight
  case botLeft, botCenter, botRight
}

enum PlayersTurn: String {
  case playerOne, playerTwo
}

enum Sign: String {
  case circle = "O"
  case x = "X"
  case empty = " "
}

struct BoardSquare: Hashable {
  var square: Sign
  let position: Positions
}

func board() -> [BoardSquare]{
  var board: [BoardSquare] = []
  for square in Positions.allCases {
    board.append(.init(square: .empty, position: square))
  }
  return board
}

class Board: ObservableObject {
  @Published var myBoard = board()
  @Published var playerTurn: PlayersTurn = .playerOne
  @Published var playerOneWins = 0
  @Published var playerTwoWins = 0
}

func  winCase(myArray: [BoardSquare]) -> Bool {
  var counter: Int = 0
  var myNewArray = myArray
  let winCases: Set<[Positions]> = [[.upLeft, .upCenter, .upRight], [.midleLeft, .midleCenter, .midleRight], [.botLeft, .botCenter, .botRight], [.upLeft, .midleLeft, .botLeft], [.upCenter, .midleCenter, .botCenter], [.upRight, .midleRight, .botRight], [.upLeft, .midleCenter, .botRight], [.upRight, .midleCenter, .botLeft]]
  for setCase in winCases {
    for caseIn in setCase {
      if myNewArray.contains(where: {$0.position == caseIn}) {
        counter += 1
        if counter == 3 {
          return true
        }
      }
    }
    counter = 0
    myNewArray = myArray
  }
  return false
}

struct ContentView: View {
  @ObservedObject var myBoard = Board()
  @State var showingAlert: Bool = false
  var body: some View {
    Text("this player's turn: \(myBoard.playerTurn == .playerOne ? Sign.x.rawValue : Sign.circle.rawValue)")
    Text("Player One \(myBoard.playerOneWins) - \(myBoard.playerTwoWins) Player Two").padding(.bottom)
    Grid {
      GridRow {
        ForEach(0..<3) { num in
          Button(myBoard.myBoard[num].square.rawValue) {
            if changeSign(to: num) {
              showingAlert.toggle()
            }
          }
        }
      }
      GridRow {
        ForEach(3..<6) { num in
          Button(myBoard.myBoard[num].square.rawValue) {
            if changeSign(to: num) {
              showingAlert.toggle()
            }
          }
        }
      }
      GridRow {
        ForEach(6..<9) { num in
          Button(myBoard.myBoard[num].square.rawValue) {
            if changeSign(to: num) {
              showingAlert.toggle()
            }
          }
        }
      }
    }
    .alert("\(myBoard.playerTurn.rawValue), won!!", isPresented: $showingAlert) {
      Button("OK") {
        clear()
      }
    }
    .padding()
    
    Button("Clear") {
      clear()
    }
  }
  
  func clear() {
    myBoard.myBoard = board()
    myBoard.playerTurn = .playerOne
  }
  
  func winCheck() -> Bool {
    var myPor = myBoard.myBoard
    let pl =  myBoard.playerTurn
    myPor.removeAll(where: { $0.square == .empty || $0.square == ( pl == .playerOne ? .circle : .x ) })
    if winCase(myArray: myPor) {
      return true
    } else {
      return false
    }
    
  }
  
  func changeSign(to: Int) -> Bool {
    
    if myBoard.myBoard[to].square == .empty {
      if myBoard.playerTurn == .playerOne {
        myBoard.myBoard[to].square = .x
        if winCheck() {
          return true
        }
        myBoard.playerTurn = .playerTwo
        return false
      } else {
        myBoard.myBoard[to].square = .circle
        if winCheck() {
          return true
        }
        myBoard.playerTurn = .playerOne
        return false
      }
    }
    return false
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
