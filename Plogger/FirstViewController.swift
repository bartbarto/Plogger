//
//  FirstViewController.swift
//  Plogger
//
//  Created by Bart Van Itterbeeck on 22/09/14.
//  Copyright (c) 2014 Bart Van Itterbeeck. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var tblPoos: UITableView!
    
    var pooArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //when returning to view
    override func viewWillAppear(animated: Bool) {
        tblPoos.reloadData()
    }
    
    //Swipe to delete (from UITableViewDelegate)
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        
        if(editingStyle == UITableViewCellEditingStyle.Delete){
            
            pooMgr.deletePoo(indexPath, callback: reloadTable(), tableview: tableView)
//            tblPoos.reloadData()
        }
        
        
    }
    
    func reloadTable(){
//        tblPoos.reloadData()
    }

    //UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        pooArray = pooMgr.loadPoo()
        return pooMgr.loadPoo().count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Test")
        
        pooArray = pooMgr.loadPoo()
        
        let pooType: AnyObject = pooArray[indexPath.row].valueForKey("type")!;
        
        cell.textLabel!.text = "Type \(pooType)"
        cell.detailTextLabel!.text = dateToString(pooArray[indexPath.row].valueForKey("date") as! NSDate)
                
        return cell;
    
    }
    
    func dateToString(date: NSDate) -> String{
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .ShortStyle
        
        let string = formatter.stringFromDate(date)
        
        return string
    }
}

