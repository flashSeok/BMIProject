//
//  BMICalculatorManager.swift
//  BMIProjectMVC
//
//  Created by 김현석 on 2022/08/05.
//

import UIKit


struct BMICalculatorManager {
    
    // BMI 계산 결과값 보관을 위한 변수
    var bmi: BMI?
    
    // BMI 얻기 메서드
    mutating func getBMI(height: String, weight: String) -> BMI {
        
        // BMI 계산 메서드 호출
        calculateBMI(height: height, weight: weight)
        
        // BMI 리턴
        return bmi ?? BMI(value: 0.0, advice: "문제발생", matchColor: .white)
        
    }
    
    // BMI 계산 메서드
    mutating private func calculateBMI(height: String, weight: String) {
        guard let h = Double(height), let w = Double(weight) else {
            bmi = BMI(value: 0.0, advice: "문제 발생", matchColor: .white)
            return
        }
        
        var bmiNum = w / (h * h) * 10000
        bmiNum = round(bmiNum * 10) / 10
        
        switch bmiNum {
        case ..<18.6:
            let color =  UIColor(displayP3Red: 22/255, green: 231/255, blue: 207/255, alpha: 1)
            bmi = BMI(value: bmiNum, advice: "저체중", matchColor: color)
            
        case 18.6..<23.0:
            let color =   UIColor(displayP3Red: 212/255, green: 251/255, blue: 121/255, alpha: 1)
            bmi = BMI(value: bmiNum, advice: "표준", matchColor: color)
            
        case 23.0..<25.0:
            let color =   UIColor(displayP3Red: 218/255, green: 127/255, blue: 163/255, alpha: 1)
            bmi = BMI(value: bmiNum, advice: "과체중", matchColor: color)
            
        case 25.0..<30.0:
            let color =   UIColor(displayP3Red: 255/255, green: 150/255, blue: 141/255, alpha: 1)
            bmi = BMI(value: bmiNum, advice: "중도 비만", matchColor: color)
            
        case 30.0...:
            let color =   UIColor(displayP3Red: 255/255, green: 100/255, blue: 78/255, alpha: 1)
            bmi = BMI(value: bmiNum, advice: "고도 비만", matchColor: color)
            
        default:
            bmi = BMI(value: 0.0, advice: "문제 발생", matchColor: .white)
            break
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //    // 구조체로 만들면 프로퍼티(bmi) 변수를 수정해야하므로 mutating 키워드 입력
//    mutaing func calculateBMI(height: String, weight: String) {
//
//        guard let h = Double(height), let w = Double(weight) else {
//            bmi = 0.0
//            return
//        }
//
//        var bmiNumber = w / (h * h) * 10000
//        bmi = round(bmiNumber * 10) / 10
//    }
//
//    func getBMIResult() -> BMI {
//        return bmi ?? BMI(value: 0.0, matchColor: .white, advice: "문제 발생")
//    }
//
//    func getBackgroundColor() -> UIColor {
//        guard let bmi = bmi else { return UIColor.black }
//
//        switch bmi {
//            case ..<18.6:
//                    return UIColor(displayP3Red: 22/255, green: 231/255, blue: 207/255, alpha: 1)
//            case 18.6..<23.0:
//                return UIColor(displayP3Red: 212/255, green: 251/255, blue: 121/255, alpha: 1)
//            case 23.0..<25.0:
//                return UIColor(displayP3Red: 218/255, green: 127/255, blue: 163/255, alpha: 1)
//            case 25.0..<30.0:
//                return UIColor(displayP3Red: 255/255, green: 150/255, blue: 141/255, alpha: 1)
//            case 30.0...:
//                return UIColor(displayP3Red: 255/255, green: 100/255, blue: 78/255, alpha: 1)
//            default:
//                return UIColor.black
//        }
//    }
//
//    func getBMIAdviceString() -> String {
//        guard let bmi = bmi else { return "" }
//
//        switch bmi {
//        case ..<18.6:
//            return "저체중"
//        case 18.6..<23.0:
//            return "표준"
//        case 23.0..<25.0:
//            return "과체중"
//        case 25.0..<30.0:
//            return "중도비만"
//        case 30.0...:
//            return "고도비만"
//        default:
//            return ""
//        }
//
//    }
    
    
}
