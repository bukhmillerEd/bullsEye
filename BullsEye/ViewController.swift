import UIKit

final class ViewController: UIViewController {
  @IBOutlet weak private var targetLabel: UILabel!
  @IBOutlet weak private var scoreLabel: UILabel!
  @IBOutlet weak var roundLabel: UILabel!
  @IBOutlet weak private var slider: UISlider!
  
  private var currentValue = 0
  private var targetValue = 0
  private var score = 0
  private var round = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    startNewGame()
    
    let tumbImageNormal = UIImage(named: "SliderThumb-Normal")!
    slider.setThumbImage(tumbImageNormal, for: .normal)
    
    let tumbImageHeightlightet = UIImage(named: "SliderThumb-Highlighted")!
    slider.setThumbImage(tumbImageHeightlightet, for: .highlighted)
    
    let insets = UIEdgeInsets(
      top: 0,
      left: 14,
      bottom: 0,
      right: 14)
    let trackLeftImage = UIImage(named: "SliderTrackLeft")!
    let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
    slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
    let trackRightImage = UIImage(named: "SliderTrackRight")!
    let trackRightResizable = trackRightImage.resizableImage(
      withCapInsets: insets)
    slider.setMaximumTrackImage(trackRightResizable, for: .normal)
  }
  
  @IBAction private func sliderMoved(_ slider: UISlider) {
    currentValue = lroundf(slider.value)
  }
  
  @IBAction private func showAlert() {
    let difference = abs(targetValue - currentValue)
    var points = 100 - difference
    
    let title: String
    if difference == 0 {
      title = "Perfect!"
      points += 100
    } else if difference < 5 {
      title = "You almost had it!"
      if difference == 1 {
        points += 50 }
    } else if difference < 10 {
      title = "Pretty good!"
    } else {
      title = "Not even close..."
    }
    score += points
    
    let message = "You scored \(points) points"
    let alert = UIAlertController(
      title: title,
      message: message,
      preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default) { _ in
      self.startNewRound()
    }
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
  
  @IBAction private func startOver(_ sender: Any) {
    startNewGame()
  }
  
  private func startNewRound() {
    targetValue = Int.random(in: 1...100)
    currentValue = 50
    slider.value = Float(currentValue)
    round += 1
    updateLabels()
  }
  
  private func updateLabels() {
    targetLabel.text = String(targetValue)
    scoreLabel.text = String(score)
    roundLabel.text = String(round)
  }
  
  private func startNewGame() {
    score = 0
    round = 0
    startNewRound()
    let transition = CATransition()
    transition.type = CATransitionType.fade
    transition.duration = 1
    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
    view.layer.add(transition, forKey: nil)
  }
}

