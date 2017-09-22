//
//  ViewController.swift
//  SwiftToDoList
//
//  Created by Jon Smith on 9/21/17.
//  Copyright (c) 2017 Jon Smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TableViewCellDelegate {

    @IBOutlet var tableView: UITableView!
    
    var toDoItems = [ToDoItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "cell")
        
        //Manipulate style elements.
        
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.blackColor()
        tableView.rowHeight = 50.0
        
        // Do any additional setup after loading the view, typically from a nib.
        
        if toDoItems.count > 0 {
            return
        }
        toDoItems.append(ToDoItem(text: "review JAVA"))
        toDoItems.append(ToDoItem(text: "learn Android Studio"))
        toDoItems.append(ToDoItem(text: "develop Android App"))
        toDoItems.append(ToDoItem(text: "Review C++"))
        toDoItems.append(ToDoItem(text: "install software (xCode)"))
        toDoItems.append(ToDoItem(text: "learn xCode IDE"))
        toDoItems.append(ToDoItem(text: "learn iOS theory"))
        toDoItems.append(ToDoItem(text: "learn Object C"))
        toDoItems.append(ToDoItem(text: "create practice apps"))
        toDoItems.append(ToDoItem(text: "learn Swift"))
        toDoItems.append(ToDoItem(text: "Do Interviews"))
        toDoItems.append(ToDoItem(text: "Get An App Developer Position..."))
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell",
                forIndexPath: indexPath) as! TableViewCell
            cell.selectionStyle = .None
            let item = toDoItems[indexPath.row]

            cell.delegate = self
            cell.toDoItem = item
            
            return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath
        indexPath: NSIndexPath) -> CGFloat {
            return tableView.rowHeight;
    }
    
    func toDoItemDeleted(toDoItem: ToDoItem) {
        let index = (toDoItems as NSArray).indexOfObject(toDoItem)
        if index == NSNotFound { return }
        
        // could removeAtIndex in the loop but keep it here for when indexOfObject works
        toDoItems.removeAtIndex(index)
        
        // use the UITableView to animate the removal of this row
        tableView.beginUpdates()
        let indexPathForRow = NSIndexPath(forRow: index, inSection: 0)
        tableView.deleteRowsAtIndexPaths([indexPathForRow], withRowAnimation: .Fade)
        tableView.endUpdates()    
    }
    
    // MARK: - Table view delegate
    
    func colorForIndex(index: Int) -> UIColor {
        let itemCount = toDoItems.count - 1
        let val = (CGFloat(index) / CGFloat(itemCount)) * 0.6
        return UIColor(red: 1.0, green: val, blue: 0.0, alpha: 1.0)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath) {
            cell.backgroundColor = colorForIndex(indexPath.row)
    }

}

