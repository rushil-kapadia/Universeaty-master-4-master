//
//  DetailsVC.swift
//  Universeaty
//
//  Created by Mark Endo on 6/25/17.
//  Copyright © 2017 Mark Endo. All rights reserved.
//

import UIKit
import Firebase

class DetailsVC: UIViewController {

    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var mealTime: UILabel!
    @IBOutlet weak var postLocation: UILabel!
    @IBOutlet weak var spotsLeft: UILabel!
    
    @IBOutlet weak var cookSpots: UILabel!
    @IBOutlet weak var cook1: UILabel!
    @IBOutlet weak var cook2: UILabel!
    @IBOutlet weak var cook3: UILabel!
    @IBOutlet weak var addCook: UIButton!
    
    @IBOutlet weak var cleanupSpots: UILabel!
    @IBOutlet weak var cleanup1: UILabel!
    @IBOutlet weak var cleanup2: UILabel!
    @IBOutlet weak var cleanup3: UILabel!
    @IBOutlet weak var addCleanup: UIButton!
    
    @IBOutlet weak var groceriesSpots: UILabel!
    @IBOutlet weak var groceries1: UILabel!
    @IBOutlet weak var groceries2: UILabel!
    @IBOutlet weak var groceries3: UILabel!
    @IBOutlet weak var addGroceries: UIButton!
    
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var post: Post!
    var cookCount = 0
    var cleanupCount = 0
    var groceriesCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postTitle.text = post.postTitle
        mealTime.text = post.mealTime
        postLocation.text = post.postLocation
        spotsLeft.text = "\(post.spotsLeft) spots left"
        
        addCook.layer.cornerRadius = 3
        addCleanup.layer.cornerRadius = 3
        addGroceries.layer.cornerRadius = 3
        undoButton.layer.cornerRadius = 3
        
        
        
        
        
        if post.initialSpots == 4 {
            //two cooks, one cleanup, one grocery
            
            if post.cooks != nil {
                cookSpots.text = "Cook (\(2 - post.cooks.count) left)"
                if post.cooks.count >= 2 {
                    addCook.isHidden = true
                }
            } else {
                cookSpots.text = "Cook (2 left)"
            }
            
            if post.cleanup != nil {
                cleanupSpots.text = "Cleanup (\(1 - post.cleanup.count) left)"
                if post.cleanup.count >= 1 {
                    addCleanup.isHidden = true
                }
            } else {
                cleanupSpots.text = "Cleanup (1 left)"
            }
            if post.groceries != nil {
                groceriesSpots.text = "Groceries (\(1 - post.groceries.count) left)"
                if post.groceries.count >= 1 {
                    addGroceries.isHidden = true
                }
            } else {
                groceriesSpots.text = "Groceries (1 left)"
            }
            
        } else if post.initialSpots == 6 {
            //two cooks, two cleanup, two groceries
            
            if post.cooks != nil {
                cookSpots.text = "Cook (\(2 - post.cooks.count) left)"
                if post.cooks.count >= 2 {
                    addCook.isHidden = true
                }
            } else {
                cookSpots.text = "Cook (2 left)"
            }
            
            if post.cleanup != nil {
                cleanupSpots.text = "Cleanup (\(2 - post.cleanup.count) left)"
                if post.cleanup.count >= 2 {
                    addCleanup.isHidden = true
                }
            } else {
                cleanupSpots.text = "Cleanup (2 left)"
            }
            if post.groceries != nil {
                groceriesSpots.text = "Groceries (\(2 - post.groceries.count) left)"
                if post.groceries.count >= 2 {
                    addGroceries.isHidden = true
                }
            } else {
                groceriesSpots.text = "Groceries (2 left)"
            }
            
        } else if post.initialSpots == 8 {
            //three cooks, three cleanup, two groceries
            
            if post.cooks != nil {
                cookSpots.text = "Cook (\(3 - post.cooks.count) left)"
                if post.cooks.count >= 3 {
                    addCook.isHidden = true
                }
            } else {
                cookSpots.text = "Cook (3 left)"
            }
            
            if post.cleanup != nil {
                cleanupSpots.text = "Cleanup (\(3 - post.cleanup.count) left)"
                if post.cleanup.count >= 3 {
                    addCleanup.isHidden = true
                }
            } else {
                cleanupSpots.text = "Cleanup (3 left)"
            }
            if post.groceries != nil {
                groceriesSpots.text = "Groceries (\(2 - post.groceries.count) left)"
                if post.groceries.count >= 2 {
                    addGroceries.isHidden = true
                }
            } else {
                groceriesSpots.text = "Groceries (2 left)"
            }
        }
        
        if post.cooks != nil {
            for x in post.cooks {
                
                if UserDefaults.standard.value(forKey: "uid") as? String == x.key {
                    if ((UserDefaults.standard.value(forKey: "name") as? String) != x.value["name"]) {
                        
                        Database.database().reference().child("posts").child(post.postID).child("cooks").child(x.key).removeValue()
                        
                        Database.database().reference().child("posts").child(post.postID).child("cooks").child(UserDefaults.standard.value(forKey: "uid") as! String).child("name").setValue(UserDefaults.standard.value(forKey: "name"))
                        
                        refreshPage()
                    }
                    addCook.isHidden = true
                    addCleanup.isHidden = true
                    addGroceries.isHidden = true
                    undoButton.isHidden = false
                }
                
                cookCount = cookCount + 1
                switch (cookCount) {
                case 1:
                    cook1.isHidden = false
                    cook1.text = x.value["name"]
                case 2:
                    cook2.isHidden = false
                    cook2.text = x.value["name"]
                case 3:
                    cook3.isHidden = false
                    cook3.text = x.value["name"]
                default: break
                    
                }

            }
        }
        
        if post.cleanup != nil {
            for x in post.cleanup {
                
                if UserDefaults.standard.value(forKey: "uid") as? String == x.key {
                    if ((UserDefaults.standard.value(forKey: "name") as? String) != x.value["name"]) {
                        
                        Database.database().reference().child("posts").child(post.postID).child("cleanup").child(x.key).removeValue()
                        
                        Database.database().reference().child("posts").child(post.postID).child("cleanup").child(UserDefaults.standard.value(forKey: "uid") as! String).child("name").setValue(UserDefaults.standard.value(forKey: "name"))
                        
                         refreshPage()
                    }
                    addCook.isHidden = true
                    addCleanup.isHidden = true
                    addGroceries.isHidden = true
                    undoButton.isHidden = false
                }
                
                
                cleanupCount = cleanupCount + 1
                switch (cleanupCount) {
                case 1:
                    cleanup1.isHidden = false
                    cleanup1.text = x.value["name"]
                case 2:
                    cleanup2.isHidden = false
                    cleanup2.text = x.value["name"]
                case 3:
                    cleanup3.isHidden = false
                    cleanup3.text = x.value["name"]
                default: break
                    
                }
                }
        }
        
        
        if post.groceries != nil {
            for x in post.groceries {
        
                if UserDefaults.standard.value(forKey: "uid") as? String == x.key {
                    (print("working part 1"))
                    if ((UserDefaults.standard.value(forKey: "name") as? String) != x.value["name"]) {

                        Database.database().reference().child("posts").child(post.postID).child("groceries").child(x.key).removeValue()
                        Database.database().reference().child("posts").child(post.postID).child("groceries").child(UserDefaults.standard.value(forKey: "uid") as! String).child("name").setValue(UserDefaults.standard.value(forKey: "name"))

                        refreshPage()
                        
                        
                        
                        
                    }
                    addCook.isHidden = true
                    addCleanup.isHidden = true
                    addGroceries.isHidden = true
                    undoButton.isHidden = false
                }
                
                groceriesCount = groceriesCount + 1
                switch (groceriesCount) {
                case 1:
                    groceries1.isHidden = false
                    groceries1.text = x.value["name"]
                case 2:
                    groceries2.isHidden = false
                    groceries2.text = x.value["name"]
                case 3:
                    groceries3.isHidden = false
                    groceries3.text = x.value["name"]
                default: break
                    
                }
                
            }
        }
        
        
        
        
        
        
        if UserDefaults.standard.value(forKey: "uid") as? String == post.postCreator {
            deleteButton.isHidden = false
        } else {
            deleteButton.isHidden = true
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addCook(_ sender: UIButton) {
        Database.database().reference().child("posts").child(post.postID).child("cooks").child(UserDefaults.standard.value(forKey: "uid") as! String).child("name").setValue(UserDefaults.standard.value(forKey: "name"))
        Database.database().reference().child("posts").child(post.postID).child("spotsLeft").setValue(self.post.spotsLeft - 1)
        refreshPage()
    }
    
    @IBAction func addCleanup(_ sender: UIButton) {
        Database.database().reference().child("posts").child(post.postID).child("cleanup").child(UserDefaults.standard.value(forKey: "uid") as! String).child("name").setValue(UserDefaults.standard.value(forKey: "name"))
        Database.database().reference().child("posts").child(post.postID).child("spotsLeft").setValue(self.post.spotsLeft - 1)
        refreshPage()
    }
    
    @IBAction func addGroceries(_ sender: UIButton) {
        Database.database().reference().child("posts").child(post.postID).child("groceries").child(UserDefaults.standard.value(forKey: "uid") as! String).child("name").setValue(UserDefaults.standard.value(forKey: "name"))
        Database.database().reference().child("posts").child(post.postID).child("spotsLeft").setValue(self.post.spotsLeft - 1)
        refreshPage()
    }
    
    
    
    
    @IBAction func onDeletePressed(_ sender: UIButton) {
        Database.database().reference().child("posts").child(post.postID).removeValue()
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onBackPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onUndoPressed(_ sender: UIButton) {
        
        undoButton.isHidden = true
        
        addCook.isHidden = false
        addCleanup.isHidden = false
        addGroceries.isHidden = false
        
        Database.database().reference().child("posts").child(post.postID).child("spotsLeft").setValue(self.post.spotsLeft + 1)

        if post.cooks != nil {
            for x in post.cooks {
                if x.key == UserDefaults.standard.value(forKey: "uid") as! String {
                    Database.database().reference().child("posts").child(post.postID).child("cooks").child(x.key).removeValue()
                    
                    cook1.isHidden = true
                    cook2.isHidden = true
                    cook3.isHidden = true
                    
                    self.refreshPage()
                    return
                }
            }
        }
        
        if post.cleanup != nil {
            for x in post.cleanup {
                if x.key == UserDefaults.standard.value(forKey: "uid") as! String {
                    Database.database().reference().child("posts").child(post.postID).child("cleanup").child(x.key).removeValue()
                    
                    cleanup1.isHidden = true
                    cleanup2.isHidden = true
                    cleanup3.isHidden = true
                    
                    self.refreshPage()
                    return
                }
            }
        }
        
        if post.groceries != nil {
            for x in post.groceries {
                if x.key == UserDefaults.standard.value(forKey: "uid") as! String {
                    Database.database().reference().child("posts").child(post.postID).child("groceries").child(x.key).removeValue()
                    
                    groceries1.isHidden = true
                    groceries2.isHidden = true
                    groceries3.isHidden = true
                    
                    self.refreshPage()
                    return
                }
            }
        }
    }
    
    func refreshPage() {
        Database.database().reference().child("posts").child(post.postID).observeSingleEvent(of: .value, with: { (snapshot) in
            if let postDict = snapshot.value as? Dictionary<String, AnyObject> {
                let refreshPost = Post(dictionary: postDict)
                self.post = refreshPost
                //first post on top
                self.cookCount = 0
                self.cleanupCount = 0
                self.groceriesCount = 0
                self.viewDidLoad()
            }
        })
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
