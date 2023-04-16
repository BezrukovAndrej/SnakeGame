import UIKit

class MainViewController: UIViewController {
    
    private var mainView: MainView {
        view as! MainView
    }
    
    private var gameModel = GameModel()
    private let snakeModel = SnakeModel()
    private let addPointModel = AddPointModel()
    private let controlModel = ControlModel()
    private let gameTimer = GameTimer()
    
    //MARK: - LifeCycle
    
    override func loadView() {
        self.view = MainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameModel = GameModel(snake: snakeModel, addPoint: addPointModel)
        setupDelegate()
        gameTimer.startTimer()
    }
    
    private func setupDelegate() {
        mainView.joystickView.joyticDelegate = self
        mainView.boardView.boardDelegare = self
        gameTimer.timerDelegate = self
        
    }
    
    private func updateUI() {
        mainView.boardView.snake = snakeModel.snake
        mainView.boardView.addPoint = CGPoint(x: addPointModel.coordinate.col,
                                              y: addPointModel.coordinate.row)
        mainView.scoreLabel.text = gameModel.gameScore.score
        mainView.nextLevelLabel.text = gameModel.gameScore.nextLevel
        mainView.boardView.setNeedsDisplay()
    }
}

//MARK: - TimerProtocol

extension MainViewController: TimerProtocol {
    func timerAction() {
        snakeModel.checkDirection(controlModel.direction)
        snakeModel.moveSnake()
        
        if gameModel.checkNextLevel() {
            gameTimer.speedIncrease()
        }
        
        if !gameModel.isOnBoard() || !gameModel.crashSnake() {
            gameTimer.stopTimer()
        } else {
            updateUI()
        }
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
