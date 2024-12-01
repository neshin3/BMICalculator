//
//  BMIViewController.swift
//  BMICalculator
//
//  Created by Nestor on 11/28/24.
//
import UIKit

class BMIViewController: UIViewController {

    @IBOutlet weak var obesityBar: UIProgressView!
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var bmiValue: Double = 0.0
    var bmiCategory: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    func updateUI() {
        bmiLabel.text = String(format: "BMI: %.2f", bmiValue)
        categoryLabel.text = "Category: \(bmiCategory)"
        
        // Normalize BMI for progress bar (assume MinBMI = 10, MaxBMI = 40)
        let minBMI: Double = 10.0
        let maxBMI: Double = 40.0
        let normalizedBMI = max(0.0, min((bmiValue - minBMI) / (maxBMI - minBMI), 1.0))
        
        obesityBar.setProgress(Float(normalizedBMI), animated: true)
        
        // Change progress bar color based on category
        switch bmiCategory {
        case "Underweight":
            obesityBar.progressTintColor = UIColor.blue
        case "Normal Weight":
            obesityBar.progressTintColor = UIColor.green
        case "Overweight":
            obesityBar.progressTintColor = UIColor.orange
        default:
            obesityBar.progressTintColor = UIColor.red
        }
    }
}
