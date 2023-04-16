import UIKit

protocol JoysticProtocol: AnyObject {
    func changePointLocation( _ point: CGPoint)
}

class JoystickView: UIView {
    
    weak var joyticDelegate: JoysticProtocol?
    
    private let centerView = UIView()
    
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
            
            let point = CGPoint(x: location.x - 50, y:50 - location.y)
            joyticDelegate?.changePointLocation(point)
        }
    }
}
