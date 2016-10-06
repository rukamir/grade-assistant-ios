//
//  CollectionTableViewController.swift
//  Roland Grading Assistant
//
//  Created by Jimmy Roland on 5/5/16.
//  Copyright © 2016 Jimmy Roland. All rights reserved.
//

import UIKit

class CollectionTableViewController: UITableViewController {
    // MARK: Properties
    var collections = [Collection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var call = Collection(name: "test1", answers: ["a","b"])
        collections += [call]
        call = Collection(name: "test2", answers: ["a","b","c"])
        collections += [call]
        call = Collection(name: "test3", answers: ["a","b","c","d"])
        collections += [call]
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        tableView.allowsSelectionDuringEditing = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Number of rows
        return collections.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "CollectionTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CollectionTableViewCell
        //(cellIdentifier, forIndexPath: indexPath) as! CollectionTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let collection = collections[indexPath.row]
        
        //cell.name.text = String(collection.answers.count)
        cell.name.text = collection.name
        
        return cell
    }
    
    // MARK: Handle when cell is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            print("is in edit mode")
            performSegue(withIdentifier: "EditCollection", sender: tableView.cellForRow(at: indexPath))
        } else {
            print("Not in edit mode")
                    }
    }
    
    // MARK: Editing behavior
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: animated)
        print("editmode")
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            collections.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    /*override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }*/
    
    // MARK: Segue    
    @IBAction func unwindToCollectionList(unwindSegue: UIStoryboardSegue) {
        
        if let sourceViewController = unwindSegue.source as? AnswerInputViewController {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // We just came bac kafter having an existing one selected
                collections[selectedIndexPath.row] = sourceViewController.collection
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                // Nothing was selected and we are coming back from a newly created
                let newIndexPath = IndexPath(row: collections.count, section: 0)
                collections.append(sourceViewController.collection)
                tableView.insertRows(at: [newIndexPath], with: .bottom)
            }
            
            /* let collection = Collection(name: sourceViewController.name, answers: sourceViewController.answerChoices)
             collections += [collection]
             
             print(tableView.indexPathForSelectedRow?.row)
             let newIndexPath = NSIndexPath(row: self.collections.count, section: 0)
             */
        }
    }
    
    @IBAction override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        print("unwind override")
    }
    
    @IBAction func UnwindToCollectionList1(sender: UIStoryboard) {

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        if segue.identifier == "EditCollection" {
            print("segue EditCollection")
            let answerInputViewController = segue.destination as! AnswerInputViewController
            
            if let selectedCollectionCell = sender as? CollectionTableViewCell {
                //let indexPath = tableView.indexPathForCell(selectedMealCell)!
                let indexPath = tableView.indexPath(for: selectedCollectionCell)
                //let selectedMeal = meals[indexPath.row]
                let selectedCollection = collections[(indexPath?.row)!]
                //mealDetailViewController.meal = selectedMeal
                answerInputViewController.collection = selectedCollection
            }
        } else {
            print(segue.identifier)
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation


    */

}
