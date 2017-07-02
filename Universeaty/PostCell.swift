//
//  PostCell.swift
//  Universeaty
//
//  Created by Mark Endo on 6/21/17.
//  Copyright © 2017 Mark Endo. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var mealTime: UILabel!
    @IBOutlet weak var postLocation: UILabel!
    @IBOutlet weak var spotsLeft: UILabel!
    
    var post: Post!
    
    func configureCell(post:Post) {
        self.post = post
        
        self.postTitle.text = post.postTitle
        self.mealTime.text = post.mealTime
        self.postLocation.text = post.postLocation
        self.spotsLeft.text = "\(post.spotsLeft) spots left"
        
        //execute func for time and spots left
    }
}
