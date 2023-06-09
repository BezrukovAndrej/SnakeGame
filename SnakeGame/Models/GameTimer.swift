import Foundation

protocol TimerProtocol: AnyObject {
    func timerAction()
}

final class GameTimer {
    
    weak var timerDelegate: TimerProtocol?
    
    private var timer = Timer()
    
    private var timeInterval = 0.3
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: timeInterval,
                                     target: self, selector: #selector(timerAction),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc private func timerAction() {
        timerDelegate?.timerAction()
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    func speedIncrease() {
        timeInterval = 0.1
        stopTimer()
        startTimer()
    }
}
