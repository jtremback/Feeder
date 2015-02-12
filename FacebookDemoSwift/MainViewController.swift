//
//  MainViewController.swift
//  FacebookDemoSwift
//
//  Created by Timothy Lee on 2/11/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import FacebookSDK
//import SwiftyJSON

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    var posts: [NSDictionary]!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self

        reload()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func reload() {
        FBRequestConnection.startWithGraphPath(
            "/me/home",
            parameters: nil,
            HTTPMethod: "GET"
        ) { (
            connection: FBRequestConnection!,
            result: AnyObject!,
            error: NSError!
        ) -> Void in
            self.posts = result["data"] as Array
            println("\(self.posts)")
            self.tableView.reloadData()
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = self.posts {
            return posts.count
        } else {
            return 0
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let photo: AnyObject = self.posts[indexPath.row]["picture"] {
            let cell = tableView.dequeueReusableCellWithIdentifier("jehan.PhotoCell") as PhotoCell
            cell.statusLabel.text = "foo"
            return cell
        } else {
            let message: AnyObject = self.posts[indexPath.row]["message"]!
            let cell = tableView.dequeueReusableCellWithIdentifier("jehan.StatusCell") as StatusCell
            cell.statusLabel.text = "foo"
            return cell
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
