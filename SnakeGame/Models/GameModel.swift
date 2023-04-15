import Foundation

class GameModel {
    
    static let cols = 20
    static let rows = 40
    
    private var addPointCol = 1
    private var addPointRow = 4
    
    private var snake: [SnakeCell] = []
    
    init() {
        snake.append(SnakeCell(col: GameModel.cols - 1, row: 1))
        snake.append(SnakeCell(col: GameModel.cols, row: 1))
    }
    
    //MARK: - Randomize Snake And AddPoint
    
    private func isOnSnake(col: Int, row: Int) -> Bool {
        for cell in snake {
            if cell.col == col && cell.row == row {
                return true
            }
        }
        return false
    }
    
    private func randomizeAddPoint() {
        addPointCol = Int.random(in: 1..<GameModel.cols)
        addPointRow = Int.random(in: 1..<GameModel.rows)
        
        while isOnSnake(col: addPointCol, row: addPointRow) {
            addPointCol = Int.random(in: 1..<GameModel.cols)
            addPointRow = Int.random(in: 1..<GameModel.rows)
        }
    }
    
    private func updateSnakeAndAddPoint(newHead: SnakeCell) {
        var newSnake: [SnakeCell] = []
        newSnake.append(newHead)
        
        for i in 0..<snake.count - 1 {
            newSnake.append(snake[i])
        }
        
        let oldTail = snake[snake.count - 1]
        if snake[0].col == addPointCol && snake[0].row == addPointRow {
            newSnake.append(oldTail)
            randomizeAddPoint()
        }
        snake = newSnake
    }
    
    //MARK: - Moving Snake
    
    func moveLeft() {
        updateSnakeAndAddPoint(newHead: SnakeCell(col: snake[0].col - 1, row: snake[0].row))
    }
    
    func moveRight() {
        updateSnakeAndAddPoint(newHead: SnakeCell(col: snake[0].col + 1, row: snake[0].row))
    }
    
    func moveUp() {
        updateSnakeAndAddPoint(newHead: SnakeCell(col: snake[0].col, row: snake[0].row - 1))
    }
    
    func moveDown() {
        updateSnakeAndAddPoint(newHead: SnakeCell(col: snake[0].col, row: snake[0].row + 1))
    }
    
    //MARK: - Get Values
    
    func getSnake() -> [SnakeCell] {
        snake
    }
    
    func getAddPoint() -> (col: Int, row: Int) {
        (addPointCol, addPointRow)
    }
}
