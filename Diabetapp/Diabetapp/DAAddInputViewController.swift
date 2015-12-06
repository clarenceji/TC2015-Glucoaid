//
//  DAAddInputViewController.swift
//  Diabetapp
//
//  Created by Clarence Ji on 12/6/15.
//  Copyright © 2015 Diabetapp. All rights reserved.
//

import UIKit

class DAAddInputViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet var inputField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapGestureRecog = UITapGestureRecognizer(target: self, action: "resignFirstResponderX")
        tapGestureRecog.delegate = self
        self.view.addGestureRecognizer(tapGestureRecog)
    }
    
    func resignFirstResponderX() {
        self.inputField.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButton_Clicked(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
