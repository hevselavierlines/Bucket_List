//
//  AddEntryController.swift
//  PINCode
//
//  Created by Manuel Baumgartner on 17/03/2015.
//  Copyright (c) 2015 FH Hagenberg. All rights reserved.
//

import UIKit
import CoreData

class AddEntryController: UIViewController {
    @IBOutlet weak var entryInput: UITextField!

    @IBAction func clickDone(sender: AnyObject) {
        var desc = entryInput.text!
        
        addBucket(desc)
    }
    
    var context : NSManagedObjectContext = NSManagedObjectContext()
    
    func settingContext(_context: NSManagedObjectContext) {
        context = _context
    }
    
    func addBucket(_desc: String) {
        let bucket1 = NSEntityDescription.insertNewObjectForEntityForName("Bucket", inManagedObjectContext: context) as! Bucket
        bucket1.desc = _desc
        save()
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func save() {
            var error: NSError? = nil
            if context.hasChanges && !context.save(&error) {
                println("Error \(error) when saving context")
                abort()
            }
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
