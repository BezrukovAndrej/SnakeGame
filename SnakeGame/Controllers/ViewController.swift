import UIKit

class ViewController: UIViewController {
    
    private let boardView = BoardView()
    private let joystickView = JoystickView()
    
    private var gameModel = GameModel()
    private let snakeModel = SnakeModel()
    private let addPointModel = AddPointModel()
    
    private var timer = Timer()
    
    private var direction: MovingDirection = .left

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        addSwipe()
        starTimer()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        gameModel = GameModel(snake: snakeModel, addPoint: addPointModel)
        
        joystickView.joyticDelegate = self
        
        view.addSubview(boardView)
        view.addSubview(joystickView)
    }
    
    //MARK: - UISwipeGestureRecognizer
    
    private func addSwipe() {
        let directions: [UISwipeGestureRecognizer.Direction] = [.left, .right, .down, .up]
        directions.forEach {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender: )))
            swipe.direction = $0
            boardView.addGestureRecognizer(swipe)
        }
    }
    
    @objc private func handleSwipe(sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case.left: direction = .left
        case.right: direction = .right
        case.up: direction = .up
        case.down: direction = .down
        default:
            break
        }
    }
    
    private func starTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.3,
                                     target: self, selector: #selector(timerAction),
                                     userInfo: nil,
                                     repeats: true)
        }
    @objc private func timerAction() {
        gameModel.checkEating()
        snakeModel.checkDirection(direction)
        snakeModel.moveSnake()
        if !gameModel.isOnBoard() || !gameModel.crashSnake() {
            timer.invalidate()
        } else {
            updateUI()
        }
    }
    
    private func updateUI() {
        boardView.snake = snakeModel
        boardView.addPoint = addPointModel
        boardView.setNeedsDisplay()
    }
}

// MARK: - JoysticProtocol

extension ViewController: JoysticProtocol {
    func changeDirection(_ direction: MovingDirection) {
        self.direction = direction
    }
}

//MARK:  - Set Constraints

extension ViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            boardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            boardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            boardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            boardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            boardView.heightAnchor.constraint(equalTo: boardView.widthAnchor, multiplier: 1),
            
            joystickView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200),
            joystickView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            joystickView.heightAnchor.constraint(equalToConstant: 100),
            joystickView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
