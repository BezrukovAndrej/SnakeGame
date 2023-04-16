import Foundation

class ControlModel {
    
    var direction: MovingDirection = .left
    
    private let triangDown = [CGPoint(x: -50.0, y: -50.0), CGPoint(x: 0.0 , y: 0.0), CGPoint(x: 50.0 , y: -50.0)]
    private let triangUp = [CGPoint(x: -50.0, y: 50.0), CGPoint(x: 0.0 , y: 0.0), CGPoint(x: 50.0 , y: 50.0)]
    private let triangRigth = [CGPoint(x: 50.0, y: 50.0), CGPoint(x: 0.0 , y: 0.0), CGPoint(x: 50.0 , y: -50.0)]
    private let triangLeft = [CGPoint(x: -50.0, y: 50.0), CGPoint(x: 0.0 , y: 0.0), CGPoint(x: -50.0 , y: -50.0)]
    
    private func defineDirection(point: CGPoint) -> MovingDirection {
        
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
    
    private func isPointInsideTriagle(_ point: CGPoint,
                                      _ triangle: [CGPoint]) -> Bool {
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
    
    func changeDirection(_ point: CGPoint) {
        let directionJoystick = defineDirection(point: point)
        if directionJoystick != direction {
            direction = directionJoystick
        }
    }
}
