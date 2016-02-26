//
//  UserSearchTableViewController.swift
//  Timeline
//
//  Created by Gibson Smiley on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class UserSearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    @IBOutlet weak var modeSegmentedControl: UISegmentedControl!
    
    var searchController: UISearchController!
    
    enum ViewMode: Int {
        case Friends
        case All
        
        func users(completion: (users: [User]?) -> Void) {
            switch self {
            case .All:
                UserController.fetchAllUsers({ (user) -> Void in
                    completion(users: user)
                })
            case .Friends:
                UserController.followedByUser(UserController.currentUser, completion: { (followed) -> Void in
                    completion(users: followed)
                })
            }
        }
    }
    
    var mode: ViewMode {
        get {
            return ViewMode(rawValue: modeSegmentedControl.selectedSegmentIndex)!
        }
    }
    
    var usersDataSource: [User] = []
    
    func updateViewBasedOnMode() {
        mode.users { (users) -> Void in
            if let users = users {
                self.usersDataSource = users
            } else {
                self.usersDataSource = []
            }
        }
        tableView.reloadData()
    }

    @IBAction func selectedIndexChanged(sender: AnyObject) {
        updateViewBasedOnMode()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpSearchController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usersDataSource.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("searchCell", forIndexPath: indexPath)

        let user = usersDataSource[indexPath.row]
        
        cell.textLabel?.text = user.username

        return cell
    }
    
    func setUpSearchController() {
        let resultsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("userSearchResultsTableViewController")
        
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = true
        
        tableView.tableHeaderView = searchController.searchBar
        
        definesPresentationContext = true
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchTerm = searchController.searchBar.text ?? ""
        let lowercaseSearchTerm = searchTerm.lowercaseString
        
        if let resultsController = searchController.searchResultsController as? UserSearchResultsTableViewController {
            resultsController.usersResultsDataSource = usersDataSource.filter({ $0.username.lowercaseString.containsString(lowercaseSearchTerm) })
            
            resultsController.tableView.reloadData()
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "searchCell" {
            
            var selectedUser: User
            
            let cell = sender as! UITableViewCell
            
            if let indexPath = (searchController.searchResultsController as! UserSearchResultsTableViewController).tableView.indexPathForCell(cell) {
                let filteredUsers = (searchController.searchResultsController as! UserSearchResultsTableViewController).usersResultsDataSource
                
                selectedUser = filteredUsers[indexPath.row]
            } else {
                let allUsers = usersDataSource
                
                let allUsersIndexPath = tableView.indexPathForCell(cell)!
                
                selectedUser = allUsers[allUsersIndexPath.row]
            }
        }
    }
}









