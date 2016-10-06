//
//  ViewController.swift
//  Shopping Alert
//
//  Created by Gabriel Theodoropoulos on 12/11/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var txtAddItem: UITextField!
    
    @IBOutlet weak var tblShoppingList: UITableView!
    
    @IBOutlet weak var btnAction: UIButton!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var shoppingList: NSMutableArray!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tblShoppingList.delegate = self
        self.tblShoppingList.dataSource = self
        
        loadShoppingList()
        
        self.txtAddItem.delegate = self
        
        datePicker.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: IBAction method implementation

    @IBAction func scheduleReminder(sender: AnyObject) {
        
    }
    
    
    // MARK: UITableView method implementation
    
  
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        
        if let list = shoppingList {
            rows = list.count
        }
        
        return rows
    }
    
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("idCellItem")! as UITableViewCell
        
        cell.textLabel?.text = shoppingList.objectAtIndex(indexPath.row) as! NSString as String
        
        return cell
    }
    
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            removeItemAtIndex(indexPath.row)
        }
    }
    
    
    
    func removeItemAtIndex(index: Int) {
        shoppingList.removeObjectAtIndex(index)
        
        tblShoppingList.reloadData()
        
        saveShoppingList()
    }

    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if shoppingList == nil{
            shoppingList = NSMutableArray()
        }

        shoppingList.addObject(textField.text!)
        
        tblShoppingList.reloadData()
        
        txtAddItem.text = ""
        txtAddItem.resignFirstResponder()
        
        saveShoppingList()
        
        return true
    }
    
  
    
    
    func saveShoppingList() {
        let pathsArray = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDirectory = pathsArray[0] as String
        let savePath = documentsDirectory + "shopping_list"
        shoppingList.writeToFile(savePath, atomically: true)
    }
    
    
    
    func loadShoppingList() {
        let pathsArray = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDirectory = pathsArray[0] as String
        let shoppingListPath = documentsDirectory + "shopping_list"
        
        if NSFileManager.defaultManager().fileExistsAtPath(shoppingListPath){
            shoppingList = NSMutableArray(contentsOfFile: shoppingListPath)
            tblShoppingList.reloadData()
        }
    }
    
    
}

