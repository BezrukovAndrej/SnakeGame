import UIKit

class BoardView: UIView {
    
    private let originX: CGFloat = 0
    private let originY: CGFloat = 0
    private var cellSide: CGFloat = 0
    
    var snake: SnakeModel?
    var addPoint: AddPointModel?

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cellSide = frame.width / CGFloat(GameModel.cols)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        drowGrid()
        drawAddPoint()
        drawSnake()
    }
    
    private func drowGrid() {
        
        let gridPath = UIBezierPath()
        
        for i in 0...GameModel.rows {
            gridPath.move(to: CGPoint(x: originX,
                                      y: originY + CGFloat(i) * cellSide))
            gridPath.addLine(to: CGPoint(x: originX + CGFloat(GameModel.cols) * cellSide,
                                         y: originY + CGFloat(i) * cellSide))
        }
        
        for i in 0...GameModel.cols {
            gridPath.move(to: CGPoint(x: originX + CGFloat(i) * cellSide,
                                      y: originY))
            gridPath.addLine(to: CGPoint(x: originX + CGFloat(i) * cellSide,
                                         y: originY + CGFloat(GameModel.rows) * cellSide))
        }
        
        SnakeColor.grid.setStroke()
        gridPath.stroke()
    }
    
    private func drawSnake() {
        
        guard let snake, !snake.snake.isEmpty, let snakeHead = snake.snake.first else { return }
        
        SnakeColor.snakeHead.setFill()
        UIBezierPath(roundedRect: CGRect(x: originX + CGFloat(snakeHead.col) * cellSide,
                                         y: originY + CGFloat(snakeHead.row) * cellSide,
                                         width: cellSide,
                                         height: cellSide),
                     cornerRadius: 5).fill()
        
        SnakeColor.snakeBody.setFill()
        for i in 1..<snake.snake.count {
            let cell = snake.snake[i]
            UIBezierPath(roundedRect: CGRect(x: originX + CGFloat(cell.col) * cellSide,
                                             y: originY + CGFloat(cell.row) * cellSide,
                                             width: cellSide,
                                             height: cellSide),
                         cornerRadius: 5).fill()
        }
    }
    
    private func drawAddPoint() {
        guard let addPoint else { return }
        SnakeColor.addPoint.setFill()
        UIBezierPath(roundedRect: CGRect(x: originX + CGFloat(addPoint.coordinate.col) * cellSide,
                                         y: originY + CGFloat(addPoint.coordinate.row) * cellSide,
                                         width: cellSide,
                                         height: cellSide),
                     cornerRadius: 5).fill()
    }
}
