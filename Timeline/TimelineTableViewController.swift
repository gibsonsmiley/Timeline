//
//  TimelineTableViewController.swift
//  Timeline
//
//  Created by Gibson Smiley on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class TimelineTableViewController: UITableViewController {

    @IBAction func refreshController(sender: AnyObject) {
        loadTimelineForUser(UserController.currentUser)
    }
    
    override func viewWillAppear(animated: Bool) {
        if UserController.currentUser == nil {
            performSegueWithIdentifier("signupLoginModalSegue", sender: self)
        }
    }
    
    var posts: [Post] = []
    
    func loadTimelineForUser(user: User) {
        PostController.fetchTimelineForUser(UserController.currentUser) { (post) -> Void in
            if let posts = post {
                self.posts = posts
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let currentUser = UserController.currentUser {
            if posts.count > 0 {
                loadTimelineForUser(currentUser)
            } else {
                self.refreshControl?.endRefreshing()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("timelineCell", forIndexPath: indexPath) as! PostTableViewCell
        let post = posts[indexPath.row]
        cell.updateWithPost(post)
        return cell
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
        
        if segue.identifier == "toPostDetailView" {
            let destinationViewController = segue.destinationViewController as! PostDetailTableViewController
            
            if let cell = sender as? PostTableViewCell, let indexPath = tableView.indexPathForCell(cell) {
                let post = self.posts
                destinationViewController.updateWithPost(post[indexPath.row])
            }
        }
    }
}
