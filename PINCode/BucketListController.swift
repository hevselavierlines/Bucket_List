//
//  BucketListController.swift
//  PINCode
//
//  Created by Manuel Baumgartner on 17/03/2015.
//  Copyright (c) 2015 FH Hagenberg. All rights reserved.
//

import UIKit
import CoreData

class BucketListController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cellIdentifier = "bucketlist"
    var tableData = [Bucket]()
    /**
    * Logout from the secured area back to the pin-entrance
    */
    @IBAction func logoutPresses(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    /**
    * When the view is returning the bucketlist is reloaded.
    */
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        tableData.removeAll(keepCapacity: true)
        
        let request = NSFetchRequest(entityName: "Bucket")
        request.fetchBatchSize = 20
        request.fetchLimit = 100
        
        var error: NSError? = nil
        let buckets = managedObjectContext?.executeFetchRequest(request, error: &error) as! [Bucket]
        
        for b in buckets {
            tableData.append(b)
        }
        
        self.tableView.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
    }
    
    func addBucket(_bucket: Bucket) {
        let bucket1 = NSEntityDescription.insertNewObjectForEntityForName("Bucket", inManagedObjectContext: managedObjectContext!) as! Bucket
        bucket1.desc = _bucket.desc
        
        save()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        //var cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier) as UITableViewCell
        
        cell.textLabel?.text = self.tableData[indexPath.row].desc
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Tableview edit for deleting table-rows.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            managedObjectContext?.deleteObject(tableData[indexPath.item])
            self.tableData.removeAtIndex(indexPath.item)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
            save()
        }
    }
    
    lazy var applicationDocumentsDirectory: NSURL = {
        let fileMgr = NSFileManager.defaultManager()
        return fileMgr.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first as! NSURL
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource("bucketlist", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("Bucket.sqllite")
        var error: NSError? = nil
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
            coordinator = nil
            NSLog("Unresolved error \(error), \(error!.userInfo)")
        }
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    func save() {
        if let context = managedObjectContext {
            var error: NSError? = nil
            if context.hasChanges && !context.save(&error) {
                println("Error \(error) when saving context")
                abort()
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject!) {
        
        if (segue!.identifier == "gotoAdd") {
            var svc = segue!.destinationViewController as! AddEntryController;
            
            svc.settingContext(managedObjectContext!)
            
        }
    }
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
