import UIKit

class MainViewController: UIViewController {
    
    private var mainView: MainView {
        view as! MainView
    }
    
    private var gameModel = GameModel()
    private let snakeModel = SnakeModel()
    private let addPointModel = AddPointModel()
    private let controlModel = ControlModel()
    
    private var timer = Timer()
    
    //MARK: - LifeCycle
    
    override func loadView() {
        self.view = MainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameModel = GameModel(snake: snakeModel, addPoint: addPointModel)
        setupDelegate()
        starTimer()
    }
    
    private func setupDelegate() {
        mainView.joystickView.joyticDelegate = self
        mainView.boardView.boardDelegare = self
    }
    
    //MARK: - Timer Actions
    
    private func starTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.3,
                                     target: self, selector: #selector(timerAction),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc private func timerAction() {
        gameModel.checkEating()
        snakeModel.checkDirection(controlModel.direction)
        snakeModel.moveSnake()
        if !gameModel.isOnBoard() || !gameModel.crashSnake() {
            timer.invalidate()
        } else {
            updateUI()
        }
    }
    
    private func updateUI() {
        mainView.boardView.snake = snakeModel.snake
        mainView.boardView.addPoint = CGPoint(x: addPointModel.coordinate.col,
                                              y: addPointModel.coordinate.row)
        mainView.boardView.setNeedsDisplay()
    }
}

//MARK: - BoardProtocol

extension MainViewController: BoardProtocol {
    func swipeGesture(direction: UISwipeGestureRecognizer.Direction) {
        switch direction {
        case.left: controlModel.direction = .left
        case.right: controlModel.direction = .right
        case.up: controlModel.direction = .up
        case.down: controlModel.direction = .down
        default:
            break
        }
    }
}

// MARK: - JoysticProtocol

extension MainViewController: JoysticProtocol {
    func changePointLocation(_ point: CGPoint) {
        controlModel.changeDirection(point)
    }
}
