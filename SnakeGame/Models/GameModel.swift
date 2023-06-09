import Foundation

final class GameModel {
    
    static let cols = 15
    static let rows = 15
    
    private var snake: SnakeModel?
    private var addPoint: AddPointModel?
    
    private var score = 0
    private var nextLavel = 5
    
    var gameScore: (score: String, nextLevel: String) {
        let score = "Score: \(score)"
        let nextLevel = "Next level: \(nextLavel)"
        return (score, nextLevel)
    }
    
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
    
    func checkEating() {
        guard let snake, let addPoint else { return }
        if snake.snake[0].col == addPoint.coordinate.col &&
            snake.snake[0].row == addPoint.coordinate.row {
            score += 1
            nextLavel -= 1
            snake.eatAddPoint()
            addPoint.randomizeAddPoint()
            while isOnSnake(col: addPoint.coordinate.col, row: addPoint.coordinate.row) {
                addPoint.randomizeAddPoint()
            }
        }
    }
    
    func checkNextLevel() -> Bool {
        checkEating()
        if nextLavel == 0 {
            nextLavel = 100
            return true
        }
        return false
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
