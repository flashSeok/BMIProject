//
//  ViewController.swift
//  BMIProject
//
//  Created by 김현석 on 2022/08/05.
//

import UIKit

// 직접 세그웨이로 연결
class ViewController: UIViewController {

    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var calculateButton: UIButton!
    
    var bmi: Double?
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
        
    }
    
    func makeUI() {
        heightTextField.delegate = self
        weightTextField.delegate = self
        
        mainLabel.text = "키와 몸무게를 입력해 주세요"
        
        calculateButton.clipsToBounds = true
        calculateButton.layer.cornerRadius = 5
        calculateButton.setTitle("BMI 계산하기", for: .normal)
        
        heightTextField.placeholder = "cm단위로 입력해 주세요"
        weightTextField.placeholder = "kg단위로 입력해 주세요"
        
    }

    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        
        // BMI 결과값을 뽑아내기
        guard let height = heightTextField.text,
              let weight = weightTextField.text else { return }
              
        bmi = calculateBMI(height: height, weight: weight)
        
    }
    
    // 세그웨으로 넘어가게 할지 말지
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if heightTextField.text == "" || weightTextField.text == "" {
            mainLabel.text = "키와 몸무게를 입력하셔야만 합니다."
            mainLabel.textColor = .red
            
            return false
        }
        mainLabel.text = "키와 몸무게를 입력해 주세요"
        mainLabel.textColor = .black
        
        return true
        
    }
    
    // 데이터 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toSecondVC" {
            let secondVC = segue.destination as! SecondViewController
            
            // 계산된 BMI 결과값을 다음 화면으로 전달
            secondVC.bmiNumber = self.bmi
            secondVC.bmiColor = getBackgroundColor()
            secondVC.adviceString = getBMIAdviceString()
        }
        
        // 다음 화면으로 가기전에 텍스트 필드 비우기
        heightTextField.text = ""
        weightTextField.text = ""
        
    }
    
    
    func calculateBMI(height: String, weight: String) -> Double {
        
        guard let h = Double(height), let w = Double(weight) else { return 0.0 }
        var bmi = w / (h * h) * 10000
        bmi = round(bmi * 10) / 10
        
        return bmi
    }
    
    func getBackgroundColor() -> UIColor {
        guard let bmi = bmi else { return UIColor.black }
        
        switch bmi {
            case ..<18.6:
                    return UIColor(displayP3Red: 22/255, green: 231/255, blue: 207/255, alpha: 1)
            case 18.6..<23.0:
                return UIColor(displayP3Red: 212/255, green: 251/255, blue: 121/255, alpha: 1)
            case 23.0..<25.0:
                return UIColor(displayP3Red: 218/255, green: 127/255, blue: 163/255, alpha: 1)
            case 25.0..<30.0:
                return UIColor(displayP3Red: 255/255, green: 150/255, blue: 141/255, alpha: 1)
            case 30.0...:
                return UIColor(displayP3Red: 255/255, green: 100/255, blue: 78/255, alpha: 1)
            default:
                return UIColor.black
        }
    }
    
    func getBMIAdviceString() -> String {
        guard let bmi = bmi else { return "" }
        
        switch bmi {
        case ..<18.6:
            return "저체중"
        case 18.6..<23.0:
            return "표준"
        case 23.0..<25.0:
            return "과체중"
        case 25.0..<30.0:
            return "중도비만"
        case 30.0...:
            return "고도비만"
        default:
            return ""
        }
        
    }
    

    
}

// MARK: - extension UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    // 입력할때마다 호출해서 숫자만 입력하게끔 설정
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        /* 키만 숫자입력하게 하려면 아래처럼 조건 설정하기
        if textField == heightTextField {
            if Int(string) != nil || string == "" {
                return true
         }
         return false
        }
         */
        
        // 숫자만 입력
        if Int(string) != nil || string == "" {
            return true
        }
        
        return false
    }
    
    
    // 엔터를 누르는걸 허락할지 말지
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // 두개의 텍스트필드를 모두 종료 (키보드 내려가기)
        if heightTextField.text != "", weightTextField.text != "" {
            weightTextField.resignFirstResponder()
            return true
            
        // 두번째 텍스트필드로 넘어가도록
        } else if heightTextField.text != "" {
            weightTextField.becomeFirstResponder()
            return true
        }
        return false
    }
    
    
    // 유저의 터치가 일어나면 키보드를 내려버리겠다.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        heightTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
    }
    
    
    
}

