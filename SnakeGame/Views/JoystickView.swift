import UIKit

protocol JoysticProtocol: AnyObject {
    func changeDirection( _ direction: MovingDirection)
}

class JoystickView: UIView {
    
    weak var joyticDelegate: JoysticProtocol?
    
    private let centerView = UIView()
    
    private let triangDown = [(x: -50.0, y: -50.0), (x: 0.0 , y: 0.0), (x: 50.0 , y: -50.0)]
    private let triangUp = [(x: -50.0, y: 50.0), (x: 0.0 , y: 0.0), (x: 50.0 , y: 50.0)]
    private let triangRigth = [(x: 50.0, y: 50.0), (x: 0.0 , y: 0.0), (x: 50.0 , y: -50.0)]
    private let triangLeft = [(x: -50.0, y: 50.0), (x: 0.0 , y: 0.0), (x: -50.0 , y: -50.0)]
    
    private var direction: MovingDirection = .left
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = SnakeColor.snakeHead
        layer.cornerRadius = 50
        translatesAutoresizingMaskIntoConstraints = false
        
        centerView.layer.cornerRadius = 50
        centerView.backgroundColor = .black
        centerView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        addSubview(centerView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        getDirectionByTouches(touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        getDirectionByTouches(touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        centerView.frame.origin = CGPoint(x: 0, y: 0)
    }
    
    private func getDirectionByTouches(_ touches: Set<UITouch>) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if bounds.contains(location) {
                centerView.center = location
            }
            
            let point = (x: Double(location.x - 50), y: Double(50 - location.y))
            
            let directionJoystick = defineDirection(point: point)
            if directionJoystick != direction {
                direction = directionJoystick
                joyticDelegate?.changeDirection(direction)
            }
        }
    }
    
    private func defineDirection(point: (x: Double, y: Double)) -> MovingDirection {
        
        if isPointInsideTriagle(point, triangDown) {
            return .down
        }
        
        if isPointInsideTriagle(point, triangUp) {
            return .up
        }
        
        if isPointInsideTriagle(point, triangLeft) {
            return .left
        }
        
        if isPointInsideTriagle(point, triangRigth) {
            return .right
        }
        return direction
    }
    
    private func isPointInsideTriagle(_ point: (x: Double, y: Double),
                                      _ triangle: [(x: Double, y: Double)]) -> Bool {
        let x1 = triangle[0].x
        let y1 = triangle[0].y
        let x2 = triangle[1].x
        let y2 = triangle[1].y
        let x3 = triangle[2].x
        let y3 = triangle[2].y
        let x = point.x
        let y = point.y
        
        let areaTriangle = abs((x1*(y2-y3) + x2*(y3-y1) + x3*(y1-y2))/2)
        
        let areaTriangleFirst = abs((x1*(y2-y) + x2*(y-y1) + x*(y1-y2))/2)
        let areaTriangleSecond = abs((x*(y2-y3) + x2*(y3-y) + x3*(y-y2))/2)
        let areaTriangleThird = abs((x1*(y-y3) + x*(y3-y1) + x3*(y1-y))/2)
        
        return areaTriangle == areaTriangleFirst + areaTriangleSecond + areaTriangleThird
    }
}
