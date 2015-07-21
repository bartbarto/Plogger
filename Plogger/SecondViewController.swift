//
//  SecondViewController.swift
//  Plogger
//
//  Created by Bart Van Itterbeeck on 22/09/14.
//  Copyright (c) 2014 Bart Van Itterbeeck. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var txtPooDate: UIDatePicker!
    @IBOutlet var sldrPooType: UISlider!
    
    @IBOutlet var lblShowType: UILabel!
    @IBOutlet var lblDescription: UILabel!
    
    @IBOutlet var imgHolder: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //events
    @IBAction func btnAddPoo_click(sender: UIButton){
                
        pooMgr.addPoo(txtPooDate.date, type: Int(round(sldrPooType.value)))
        //hide the keyboard
        self.view.endEditing(true)
        
        //siwtch views
        self.tabBarController?.selectedIndex = 0
    }
    
    @IBAction func sldrPooType_slide(sender: UISlider){
        
        let type = Int(round(sldrPooType.value))
        
        imgHolder.image = UIImage(named: "type_\(type)")
        
        lblShowType.text = "Type \(type)";
        
        switch(type){
            case 1:
                lblDescription.text = "Separate hard lumps, like nuts (hard to pass)"
            case 2:
                lblDescription.text = "Sausage-shaped but lumpy"
            case 3:
                lblDescription.text = "Like a sausage but with cracks on the surface"
            case 4:
                lblDescription.text = "Like a sausage or snake, smooth and soft"
            case 5:
                lblDescription.text = "Soft blobs with clear-cut edges"
            case 6:
                lblDescription.text = "Fluffy pieces with ragged edges, a mushy stool"
            case 7:
                lblDescription.text = "Watery, no solid pieces. Entirely Liquid"
            default:
                lblDescription.text = "..."
        }
        
    }
    
    //so the keyboard goes away when you tap away from the textFields
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    //UITextfield Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
}

