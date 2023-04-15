import UIKit

class BoardView: UIView {
    
    private let originX: CGFloat = 0
    private let originY: CGFloat = 0
    private var cellSide: CGFloat = 0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cellSide = frame.width / CGFloat(SnakeBoard.cols)
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
    }
    
    private func drowGrid() {
        
        let gridPath = UIBezierPath()
        
        for i in 0...SnakeBoard.rows {
            gridPath.move(to: CGPoint(x: originX,
                                      y: originY + CGFloat(i) * cellSide))
            gridPath.addLine(to: CGPoint(x: originX + CGFloat(SnakeBoard.cols) * cellSide,
                                         y: originY + CGFloat(i) * cellSide))
        }
        
        for i in 0...SnakeBoard.cols {
            gridPath.move(to: CGPoint(x: originX + CGFloat(i) * cellSide,
                                      y: originY))
            gridPath.addLine(to: CGPoint(x: originX + CGFloat(i) * cellSide,
                                         y: originY + CGFloat(SnakeBoard.rows) * cellSide))
        }
        
        SnakeColor.grid.setStroke()
        gridPath.stroke()
    }
}
