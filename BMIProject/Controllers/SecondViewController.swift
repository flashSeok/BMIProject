//
//  SecondViewController.swift
//  BMIProject
//
//  Created by 김현석 on 2022/08/05.
//

import UIKit

// 직접 세그웨이로 연결
class SecondViewController: UIViewController {

    
    
    @IBOutlet weak var bmiNumberLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var bmi: BMI?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
        guard let bmi = bmi else { return }
        
        bmiNumberLabel.text = "\(bmi.value)"
        bmiNumberLabel.backgroundColor = bmi.matchColor
        adviceLabel.text = bmi.advice        
    }
    
    func configureUI() {
        
        bmiNumberLabel.clipsToBounds = true
        bmiNumberLabel.layer.cornerRadius = 8
        bmiNumberLabel.backgroundColor = .gray
        
        backButton.setTitle("다시 계산하기", for: .normal)
        backButton.clipsToBounds = true
        backButton.layer.cornerRadius = 5
        
        guard let bmiNumber = bmi?.value else { return }
        bmiNumberLabel.text = String(bmiNumber)
        
        adviceLabel.text = bmi?.advice
        bmiNumberLabel.backgroundColor = bmi?.matchColor

    }

    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }


}
