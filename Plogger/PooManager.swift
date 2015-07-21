//
//  PooManager.swift
//  Plogger
//
//  Created by Bart Van Itterbeeck on 22/09/14.
//  Copyright (c) 2014 Bart Van Itterbeeck. All rights reserved.
//


//
// Nog toevoegen: datum, locatie, foto
//
import UIKit
import CoreData

var pooMgr:PooManager = PooManager()

struct poo {
    var date = NSDate();
    var type = 0
}

@objc


class PooManager: NSObject {
    
    var poos = [poo]()
    
    func addPoo(dato: NSDate, type: Int){
        poos.append(poo(date: dato, type: type))
        
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext!
        
        var newPoo = NSEntityDescription.insertNewObjectForEntityForName("Poos", inManagedObjectContext: context)
        newPoo.setValue(dato, forKey: "date")
        newPoo.setValue(type, forKey: "type")
        
        context.save(nil)
        
        self.loadPoo();
        
    }
    
    func loadPoo() -> Array<AnyObject>{
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext!
        
        var request = NSFetchRequest(entityName: "Poos")
        request.returnsObjectsAsFaults = false
        
        var results: NSArray = context.executeFetchRequest(request, error: nil)!
        
//        if(results.count > 0){
//            for res in results{
//                println("stuff found, about \(results.count) items")
//            }
//        }else{
//            println("nothing found... :(")
//        }
        context.save(nil)
        return results as Array
    }
    
    func deletePoo(indexPath: NSIndexPath?, callback: (), tableview: UITableView?){
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext!
        
        var req = NSFetchRequest(entityName: "Poos")
//        req.returnsObjectsAsFaults = false
        
        var list: NSArray = context.executeFetchRequest(req, error: nil)!
        
//        println("deleting item with index \(indexPath.row)")
        
        if let tv = tableview{
            context.deleteObject(list[indexPath!.row] as! NSManagedObject)
            tv.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
        
        }
        
        var error: NSError? = nil
        
        if !context.save(&error){
            abort()
        }
        
        callback
    
    }
    
}
