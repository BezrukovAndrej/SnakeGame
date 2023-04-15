import Foundation

class GameModel {
    
    static let cols = 20
    static let rows = 40
    
    private var snake: SnakeModel?
    private var addPoint: AddPointModel?
    
    init() {}
    
    init(snake: SnakeModel, addPoint: AddPointModel) {
        self.snake = snake
        self.addPoint = addPoint
    }
    
    //MARK: - Randomize Snake And AddPoint
    
    private func isOnSnake(col: Int, row: Int) -> Bool {
        guard let snake else { return true }
        for cell in snake.snake {
            if cell.col == col && cell.row == row {
                return true
            }
        }
        return false
    }
    
    private func randomizeAddPoint() {
        guard let addPoint else { return }
        let col = addPoint.coordinate.col
        let row = addPoint.coordinate.row
        while isOnSnake(col: col, row: row) {
            addPoint.randomizeAddPoint()
        }
    }
    
    func checkEating() {
        if snake?.snake[0].col == addPoint?.coordinate.col &&
            snake?.snake[0].row == addPoint?.coordinate.row {
            snake?.eatAddPoint()
            addPoint?.randomizeAddPoint()
        }
    }
    
    func isOnBoard() -> Bool {
        guard let snake else { return false }
        if snake.snake[0].row < 0 || snake.snake[0].row > GameModel.rows - 1 ||
            snake.snake[0].col < 0 || snake.snake[0].col > GameModel.cols - 1 {
            return false
        }
        return true
    }
    
    func crashSnake() -> Bool {
        guard let snake else { return false }
        
        var snakeWithoutHead = snake.snake
        snakeWithoutHead.removeFirst()
        
        let head = snake.snake[0]
        if snakeWithoutHead.contains(where: {$0.col == head.col && $0.row == head.row}) {
            return false
        }
        return true
    }
}
