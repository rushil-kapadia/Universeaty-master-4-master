//
//  Post.swift
//  Universeaty
//
//  Created by Mark Endo on 6/21/17.
//  Copyright © 2017 Mark Endo. All rights reserved.
//

import Foundation

class Post {
    
    private var _postTitle: String!
    private var _mealTime: String!
    private var _postLocation: String!
    private var _initialSpots: Int!
    private var _spotsLeft: Int!
    private var _postCreator: String!
    private var _postID: String!
    private var _cooks: Dictionary<String, Dictionary<String, String>>!
    private var _cleanup: Dictionary<String, Dictionary<String, String>>!
    private var _groceries: Dictionary<String, Dictionary<String, String>>!
    
    
    
    var postTitle: String {
        return _postTitle
    }
    
    var mealTime: String {
        return _mealTime
    }
    
    var postLocation: String {
        return _postLocation
    }
    
    var initialSpots: Int {
        return _initialSpots
    }
    
    var spotsLeft: Int {
        return _spotsLeft
    }
    
    var postCreator: String {
        return _postCreator
    }
    
    var postID: String {
        return _postID
    }
    
    var cooks: Dictionary<String, Dictionary<String, String>>! {
        return _cooks
    }
    
    var cleanup: Dictionary<String, Dictionary<String, String>>! {
        return _cleanup
    }
    
    var groceries: Dictionary<String, Dictionary<String, String>>! {
        return _groceries
    }
    
    init(dictionary: Dictionary<AnyHashable, AnyObject>) {
        
        if let title = dictionary["title"] as? String {
            self._postTitle = title
        }
        
        if let mealTime = dictionary["mealTime"] as? String {
            self._mealTime = mealTime
        }
        
        if let location = dictionary["location"] as? String {
            self._postLocation = location
        }
        
        if let initialSpots = dictionary["initialSpots"] as? Int {
            self._initialSpots = initialSpots
        }
        
        if let spotsLeft = dictionary["spotsLeft"] as? Int {
            self._spotsLeft = spotsLeft
        }
        
        if let postCreator = dictionary["postCreator"] as? String {
            self._postCreator = postCreator
        }
        
        if let postID = dictionary["postID"] as? String {
            self._postID = postID
        }
        
        if let cooks = dictionary["cooks"] as? Dictionary<String, Dictionary<String, String>>! {
            self._cooks = cooks
        }
        
        if let cleanup = dictionary["cleanup"] as? Dictionary<String, Dictionary<String, String>>! {
            self._cleanup = cleanup
        }
        
        if let groceries = dictionary["groceries"] as? Dictionary<String, Dictionary<String, String>>! {
            self._groceries = groceries
        }
    }
    
}
