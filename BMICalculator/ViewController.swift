//
//  ViewController.swift
//  BMICalculator
//
//  Created by Nestor on 11/28/24.
//
import UIKit

class ViewController: UIViewController {

    // Outlets
    @IBOutlet weak var unitType: UISegmentedControl!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var weightUnit: UILabel!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var heightUnit: UILabel!
    @IBOutlet weak var heightIn: UITextField!
    @IBOutlet weak var heightRow: UIStackView!
    @IBOutlet weak var clear: UIButton!

    // Properties to store calculated BMI and Category
    var bmiValue: Double = 0.0
    var bmiCategory: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        unitType.selectedSegmentIndex = 1 // Default to Imperial
        unitTypeChanged(unitType)
    }

    // Toggle between metric and imperial units
    @IBAction func unitTypeChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            // Metric system
            heightRow.isHidden = true
            heightUnit.text = "cm"
            weightUnit.text = "kg"
        } else {
            // Imperial system
            heightRow.isHidden = false
            heightUnit.text = "ft"
            weightUnit.text = "lb"
        }
        clearTapped(clear)
    }

    @IBAction func submitTapped(_ sender: UIButton) {
        // Dismiss keyboard
        view.endEditing(true)
    }

    // Validation before segue execution
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "showBMIView" {
            let isMetric = (unitType.selectedSegmentIndex == 0)

            // Input validation for weight
            guard let weightValue = Double(weight.text ?? ""), weightValue > 0 else {
                return false
            }

            // Input validation for height
            guard let heightValue = Double(height.text ?? ""), heightValue > 0 else {
                return false
            }

            var heightInMetersOrInches: Double
            if isMetric {
                // Metric system: Convert height from cm to meters
                heightInMetersOrInches = heightValue / 100.0
            } else {
                // Imperial system: Convert feet and inches to total inches
                guard let heightInches = Double(heightIn.text ?? ""), heightInches >= 0 else {
                    return false
                }
                heightInMetersOrInches = (heightValue * 12.0) + heightInches
            }

            // Calculate BMI using the model
            bmiValue = BMIModel.calculateBMI(weight: weightValue, height: heightInMetersOrInches, isMetric: isMetric)

            // Determine BMI category
            bmiCategory = BMIModel.getBMICategory(for: bmiValue)
            return true // Allow segue
        }
        return true // Allow other segues
    }

    @IBAction func clearTapped(_ sender: UIButton) {
        // Reset all fields
        height.text = ""
        heightIn.text = ""
        weight.text = ""
    }

    // Pass data to the next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBMIView", let destinationVC = segue.destination as? BMIViewController {
            destinationVC.bmiValue = bmiValue
            destinationVC.bmiCategory = bmiCategory
        }
    }
}
