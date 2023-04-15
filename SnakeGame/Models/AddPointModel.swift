import Foundation

class AddPointModel {
    
    private var col = 1
    private var row = 4
    
    var coordinate:(col: Int, row: Int) {
        (col, row)
    }
    
    func randomizeAddPoint() {
        col = Int.random(in: 1..<GameModel.cols)
        row = Int.random(in: 1..<GameModel.rows)
    }
}
