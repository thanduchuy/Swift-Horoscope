//
//  SecondViewController.swift
//  Zodiac
//
//  Created by MacBook Pro on 6/2/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class SecondViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    
    
    @IBOutlet weak var dateNow: UILabel!
    @IBOutlet weak var horoscope: UITextView!
    @IBOutlet weak var image: UIImageView!
    
    var activyIndicator : NVActivityIndicatorView!
    var text:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let indicatorSize : CGFloat = 70
        let indicatorFrame = CGRect(x: (view.frame.width-indicatorSize)/2, y: (view.frame.height-indicatorSize)/2, width: indicatorSize, height: indicatorSize)
        activyIndicator = NVActivityIndicatorView(frame: indicatorFrame,type:.ballBeat, color: UIColor.white, padding: 20.0)
        activyIndicator.backgroundColor = UIColor.black
        activyIndicator.layer.cornerRadius = 10
        view.addSubview(activyIndicator)
        activyIndicator.startAnimating()
        backButton.layer.cornerRadius = backButton.frame.size.width/4
    }
    override func viewWillAppear(_ animated: Bool) {
        getDataHoRoScope()
    }
    func getDataHoRoScope() {
        Alamofire.request("http://horoscope-api.herokuapp.com/horoscope/today/\(self.text)").responseJSON { response in
            if let responseStr = response.result.value {
                let jsonResponse = JSON(responseStr)
                self.dateNow.text = jsonResponse["date"].stringValue
                self.horoscope.text = jsonResponse["horoscope"].stringValue
                self.image.image = UIImage(named: jsonResponse["sunsign"].stringValue.lowercased())
            }
             self.activyIndicator.stopAnimating()
        }
    }
    @IBAction func goToBackView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
