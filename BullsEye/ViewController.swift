import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!

    let defaultValue = 50
    var targetValue = 0
    var currentValue = 0

    var score = 0
    var round = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        currentValue = Int(slider.value.rounded())
        startNewGame()
    }

    @IBAction func onHitMeClick() {
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        if difference == 0 {
            points += 100
        } else if difference == 1 {
            points += 50
        }
        score += points

        let title: String
        if difference == 0 {
            title = "Perfect!"
        } else if difference < 5 {
            title = "You almost had it!"
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close!"
        }

        let alert = UIAlertController(title: title, message: "You pressed: \(currentValue)\nScored \(points) points", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) {
            action in
            self.startNewRound()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }

    @IBAction func sliderMoved(_ slider: UISlider) {
        print("slider: \(slider.value.rounded())")
        currentValue = Int(slider.value.rounded())
    }

    func startNewRound() {
        round += 1
        targetValue = Int.random(in: 1...100)

        currentValue = defaultValue
        slider.value = Float(currentValue)

        updateLabels()
    }

    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }

    @IBAction func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
}
