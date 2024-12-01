//
//  BMIModel.swift
//  BMIModel
//
//  Created by Nestor on 11/28/24.
//

import Foundation

struct BMIModel {
    // Calculate BMI
    static func calculateBMI(weight: Double, height: Double, isMetric: Bool) -> Double {
        if isMetric {
            return weight / (height * height) // Metric BMI: weight (kg) / height^2 (m^2)
        } else {
            return (weight * 703) / (height * height) // Imperial BMI: (weight (lb) * 703) / height^2 (in^2)
        }
    }

    // Determine BMI category
    static func getBMICategory(for bmi: Double) -> String {
        switch bmi {
        case ..<18.5:
            return "Underweight"
        case 18.5..<25.0:
            return "Normal Weight"
        case 25.0..<30.0:
            return "Overweight"
        case 30.0..<35.0:
            return "Obesity (Class I)"
        case 35.0..<40.0:
            return "Obesity (Class II)"
        default:
            return "Obesity (Class III)"
        }
    }
}
