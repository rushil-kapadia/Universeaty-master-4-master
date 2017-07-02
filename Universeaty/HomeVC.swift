//
//  HomeVC.swift
//  Universeaty
//
//  Created by Mark Endo on 6/21/17.
//  Copyright © 2017 Mark Endo. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        Database.database().reference().child("posts").observe(.value, with: { snapshot in
            
            self.posts = []
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                
                for snap in snapshots {
                    
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let post = Post(dictionary: postDict)
                        self.posts.insert(post, at: 0)
                        //first post on top
                    }
                }
            }
            
            self.tableView.reloadData()
        })
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            
            let post = posts[indexPath.row]
            
            cell.configureCell(post: post)
            
            return cell
        } else {
            return PostCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let post = posts[indexPath.row]
        
        self.performSegue(withIdentifier: "ToDetails", sender: post)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetails" {
            if let detailsVC = segue.destination as? DetailsVC {
                if let post = sender as? Post {
                    detailsVC.post = post
                }
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSettingsPressed(sender: UIButton) {
        
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
