//
//  ViewController.swift
//  Zodiac
//
//  Created by MacBook Pro on 6/2/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var birthDateTxt: UITextField!
    let datePicker = UIDatePicker()
    let transition = CircularTransition()
    var dateTranfer = Date()
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.cornerRadius = nextButton.frame.size.width / 3
        birthDateTxt.layer.cornerRadius = 20
        createDatePicker()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC = segue.destination as! SecondViewController
        secondVC.transitioningDelegate = self
        secondVC.modalPresentationStyle = .custom
        secondVC.text = getNameZodiac(date: datePicker.date)
    }
    
    @IBAction func transferData(_ sender: Any) {
        dateTranfer = datePicker.date
        performSegue(withIdentifier: "tranfer", sender: self)
        birthDateTxt.text = ""
    }
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = nextButton.center
        transition.circleColor = nextButton.backgroundColor!
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = nextButton.center
        transition.circleColor = nextButton.backgroundColor!
        
        return transition
    }
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        birthDateTxt.textAlignment = .center
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done,target: nil,action : #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        birthDateTxt.inputAccessoryView = toolbar
        birthDateTxt.inputView = datePicker
        datePicker.datePickerMode = .date
    }
    @objc func donePressed() {
        let formater = DateFormatter()
        formater.dateFormat = "dd/MM/yyyy"
        birthDateTxt.text = "\(formater.string(from: datePicker.date))"
        self.view.endEditing(true)
    }
    func getNameZodiac(date: Date) -> String {
        let zodiacs = [
            zodiac(name: "Aquarius", dayStart: 20, monthStart: 1, dayEnd: 18, monthEnd: 2),
            zodiac(name: "Pisces", dayStart: 19, monthStart: 2, dayEnd: 20, monthEnd: 3),
            zodiac(name: "Aries", dayStart: 21, monthStart: 3, dayEnd: 20, monthEnd: 4),
            zodiac(name: "Taurus", dayStart: 21, monthStart: 4, dayEnd: 20, monthEnd: 5),
            zodiac(name: "Gemini", dayStart: 21, monthStart: 5, dayEnd: 21, monthEnd: 6),
            zodiac(name: "Cancer", dayStart: 22, monthStart: 6, dayEnd: 22, monthEnd: 7),
            zodiac(name: "Leo", dayStart: 23, monthStart: 7, dayEnd: 22, monthEnd: 8),
            zodiac(name: "Virgo", dayStart: 23, monthStart: 8, dayEnd: 22, monthEnd: 9),
            zodiac(name: "Libra", dayStart: 23, monthStart: 9, dayEnd: 23, monthEnd: 10),
            zodiac(name: "Scorpio", dayStart: 24, monthStart: 10, dayEnd: 22, monthEnd: 11),
            zodiac(name: "Sagittarius", dayStart: 23, monthStart: 11, dayEnd: 21, monthEnd: 12),
            zodiac(name: "Capricorn", dayStart: 22, monthStart: 12, dayEnd: 19, monthEnd: 1)
        ]
        var result = ""
        zodiacs.forEach { (zodiac) in
            if comparedDate(date: date, month: zodiac.monthStart, day: zodiac.dayStart) && !comparedDate(date: date, month: zodiac.monthEnd, day: zodiac.dayEnd) {
                result = zodiac.name
            }
        }
        return result
    }
    func comparedDate(date: Date,month: Int,day : Int) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        let monthCompared = formatter.string(from: date)
        formatter.dateFormat = "dd"
        let dayCompared = formatter.string(from: date)
        return Int(monthCompared)! > month ? true : Int(monthCompared)! == month ? Int(dayCompared)! >= day : false
    }
}

