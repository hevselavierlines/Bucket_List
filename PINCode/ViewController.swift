//
//  ViewController.swift
//  PINCode
//
//  Created by Manuel Baumgartner on 16/03/2015.
//  Copyright (c) 2015 FH Hagenberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lbText: UILabel!
    @IBOutlet weak var btPin1: UIButton!
    @IBOutlet weak var btPin2: UIButton!
    @IBOutlet weak var btPin3: UIButton!
    @IBOutlet weak var btPin4: UIButton!
    @IBOutlet weak var btPin5: UIButton!
    @IBOutlet weak var btPin6: UIButton!
    @IBOutlet weak var btPin7: UIButton!
    @IBOutlet weak var btPin8: UIButton!
    @IBOutlet weak var btPin9: UIButton!
    @IBOutlet weak var btPin0: UIButton!
    @IBOutlet weak var btPinC: UIButton!
    @IBOutlet weak var btPinOK: UIButton!
    
    var password = ""
    /**
    * After loading the existing pin-code is loade as well.
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        setCornerRadius(30.0)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "backgroundAction", name: UIApplicationDidEnterBackgroundNotification, object: nil)
        
        var defaults = NSUserDefaults.standardUserDefaults()
        if let pin = defaults.objectForKey("PIN") as? String {
            password = pin
        }
    }
    /**
    * Background-action for deleting the pin-code.
    */
    func backgroundAction() {
        clearText(self)
    }
    
    @IBAction func clearText(sender: AnyObject) {
        lbText.text = ""
    }
    /**
    * When the user clicks ok the pin is checked.
    * if ok the next viewcontroller is loaded
    * otherwise an error is printed out.
    */
    @IBAction func OKClick(sender: AnyObject) {
        if password == "" {
            password = lbText.text!
            
            var defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(password, forKey: "PIN")
            defaults.synchronize()
            
            let alert = UIAlertController(title: "PIN set", message: "PIN code set sucessfully", preferredStyle: UIAlertControllerStyle.ActionSheet)
            let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in }
            alert.addAction(alertAction)
            presentViewController(alert, animated: true) { () -> Void in }
        } else {
            if password == lbText.text! {
                performSegueWithIdentifier("gotoTable", sender: self)
            } else {
                let alert = UIAlertController(title: "Access denied!", message: "Your PIN was wrong!", preferredStyle: UIAlertControllerStyle.Alert)
                let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in }
                alert.addAction(alertAction)
                presentViewController(alert, animated: true) { () -> Void in }
            }
        }
    }
    
    @IBAction func buttonClick(sender: AnyObject) {
        if        sender as! NSObject == btPin0 {
            lbText.text?.extend("0")
        } else if sender as! NSObject == btPin1 {
            lbText.text?.extend("1")
        } else if sender as! NSObject == btPin2 {
            lbText.text?.extend("2")
        } else if sender as! NSObject == btPin3 {
            lbText.text?.extend("3")
        } else if sender as! NSObject == btPin4 {
            lbText.text?.extend("4")
        } else if sender as! NSObject == btPin5 {
            lbText.text?.extend("5")
        } else if sender as! NSObject == btPin6 {
            lbText.text?.extend("6")
        } else if sender as! NSObject == btPin7 {
            lbText.text?.extend("7")
        } else if sender as! NSObject == btPin8 {
            lbText.text?.extend("8")
        } else if sender as! NSObject == btPin9 {
            lbText.text?.extend("9")
        }
    }
    /**
    * Setting the corner radius of all buttons
    */
    func setCornerRadius (_corner: CGFloat)
    {
        btPin0.layer.cornerRadius = _corner
        btPin1.layer.cornerRadius = _corner
        btPin2.layer.cornerRadius = _corner
        btPin3.layer.cornerRadius = _corner
        btPin4.layer.cornerRadius = _corner
        btPin5.layer.cornerRadius = _corner
        btPin6.layer.cornerRadius = _corner
        btPin7.layer.cornerRadius = _corner
        btPin8.layer.cornerRadius = _corner
        btPin9.layer.cornerRadius = _corner
        btPinC.layer.cornerRadius = _corner
        btPinOK.layer.cornerRadius = _corner
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

