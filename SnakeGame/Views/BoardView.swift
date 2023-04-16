import UIKit

protocol BoardProtocol: AnyObject {
    func swipeGesture(direction: UISwipeGestureRecognizer.Direction)
}

class BoardView: UIView {
    
    weak var boardDelegare: BoardProtocol?
    
    private let originX: CGFloat = 0
    private let originY: CGFloat = 0
    private var cellSide: CGFloat = 0
    
    var snake: [SnakeCell]?
    var addPoint: CGPoint?

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cellSide = frame.width / CGFloat(GameModel.cols)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        addSwipe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        drowGrid()
        drawAddPoint()
        drawSnake()
    }
    
    //MARK: - Draw object
    
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
        
        guard let snake, !snake.isEmpty, let snakeHead = snake.first else { return }
        
        SnakeColor.snakeHead.setFill()
        UIBezierPath(roundedRect: CGRect(x: originX + CGFloat(snakeHead.col) * cellSide,
                                         y: originY + CGFloat(snakeHead.row) * cellSide,
                                         width: cellSide,
                                         height: cellSide),
                     cornerRadius: 5).fill()
        
        SnakeColor.snakeBody.setFill()
        for i in 1..<snake.count {
            let cell = snake[i]
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
        UIBezierPath(roundedRect: CGRect(x: originX + addPoint.x * cellSide,
                                         y: originY + addPoint.y * cellSide,
                                         width: cellSide,
                                         height: cellSide),
                     cornerRadius: 5).fill()
    }
    
    //MARK: - UISwipeGestureRecognizer
    
    private func addSwipe() {
        let directions: [UISwipeGestureRecognizer.Direction] = [.left, .right, .down, .up]
        directions.forEach {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender: )))
            swipe.direction = $0
            addGestureRecognizer(swipe)
        }
    }
    
    @objc private func handleSwipe(sender: UISwipeGestureRecognizer) {
        boardDelegare?.swipeGesture(direction: sender.direction)
    }
}
