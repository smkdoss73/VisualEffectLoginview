//
//  ViewController.swift
//  AnimatedLoginScreen
//
//  Created by System on 8/10/17.
//  Copyright © 2017 tesark. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var visualBlurBg: UIVisualEffectView!
    @IBOutlet weak var ctrninputviewTop: NSLayoutConstraint!
    @IBOutlet weak var tfusername: UITextField!
    
    @IBOutlet weak var tfpassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tfusername.creteSpace()
        tfpassword.creteSpace()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { 
            self.adjustviewConstraint(iskeyboard: false)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
        
        
    }
    
    
    func keyboardWillShow(notification: NSNotification) {
        adjustviewConstraint(iskeyboard: true)
        view.layoutIfNeeded()
    }
    
    func keyboardWillHide(notification: NSNotification) {
        adjustviewConstraint(iskeyboard: false)
        view.layoutIfNeeded()
    }

    
    
    
    @IBAction func onClickSubmit(_ sender: Any) {
        
        self.view.endEditing(true)
    }

}


extension ViewController  {
    
    
    func adjustviewConstraint(iskeyboard : Bool){
        
        if iskeyboard{
            
           
            ctrninputviewTop.constant = 0
            visualBlurBg.alpha = 1

        }else{
            
            var ctrnval:CGFloat = 0.0
            
            
            if UIDevice.type == UIUserInterfaceIdiom.pad{
                ctrnval = 700.0
            }else{
                
                if DeviceType.IS_IPHONE_4_OR_LESS {
                    ctrnval = 190.0
                }else if DeviceType.IS_IPHONE_5 {
                    ctrnval = 290.0
                }else if DeviceType.IS_IPHONE_6_7 {
                    ctrnval = 350.0
                }else{
                    ctrnval = 450.0
                }
                
            }
            
            ctrninputviewTop.constant = ctrnval
            visualBlurBg.alpha = 0
        }
        
    }
    
}


extension ViewController : UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}



