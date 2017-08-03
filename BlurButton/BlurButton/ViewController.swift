//
//  ViewController.swift
//  BlurButton
//
//  Created by KIEU, HAI on 8/2/17.
//  Copyright © 2017 Kieu, Ngoc Hai. All rights reserved.
//

import UIKit
import Blur

class ViewController: UIViewController {

    @IBOutlet weak var lightBlurButton: LightBlurButton!
    @IBOutlet weak var blurButton: BlurButton!
    @IBOutlet weak var darkBlurButton: DarkBlurButton!
    @IBOutlet weak var animatedSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func handleButtonClick(_ sender: Any) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func performBlur(_ sender: Any) {
        lightBlurButton.blur(animated: animatedSwitch.isOn)
    }
    @IBAction func performDeblur(_ sender: Any) {
        lightBlurButton.deBlur(animated: animatedSwitch.isOn)
    }
}

