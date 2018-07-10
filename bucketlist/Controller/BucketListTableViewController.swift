//
//  BucketListTableViewController.swift
//  bucketlist
//
//  Created by Clement  Wekesa on 07/06/2018.
//  Copyright © 2018 Clement  Wekesa. All rights reserved.
//

import UIKit

class BucketListTableViewController: UITableViewController {
    
    var buckets: [[String: Any]] = [[:]]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 88.0
        
        NetworkClient.standard.get(url: "/bucketlists", query: nil) { (status, data) in
            guard
            let data = data as? [String: Any]
                else { return }
            
            DispatchQueue.main.sync {
                self.buckets = data["bucketlist"] as! [[String: Any]]
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buckets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BucketlistTableViewCell
        
        cell.bucketlistTitle.text = buckets[indexPath.row]["name"] as? String
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ItemTableViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.items = buckets[indexPath.row]["items"] as? [[String: Any]]
        }
    }
}
