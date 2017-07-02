//
//  AddPostVC.swift
//  Universeaty
//
//  Created by Mark Endo on 6/22/17.
//  Copyright © 2017 Mark Endo. All rights reserved.
//
import UIKit
import Firebase
import MapKit
import CoreLocation

extension CLPlacemark {
    
    var compactAddress: String? {
        if let name = name {
            var result = name
            
            if let street = thoroughfare {
                result += ", \(street)"
            }
            
            if let city = locality {
                result += ", \(city)"
            }
            
            if let country = country {
                result += ", \(country)"
            }
            
            return result
        }
        
        return nil
    }
    
}


class AddPostVC: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var postTitle: UITextField!
    @IBOutlet weak var postLocation: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var fourSpotButton: UIButton!
    @IBOutlet weak var sixSpotButton: UIButton!
    @IBOutlet weak var eightSpotButton: UIButton!
    
    @IBOutlet weak var cookButton: UIButton!
    @IBOutlet weak var cleanupButton: UIButton!
    @IBOutlet weak var groceriesButton: UIButton!
    
    lazy var geocoder = CLGeocoder()
    
    var spots: Int?
    var role: String?
    
    let manager = CLLocationManager()
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        let myLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) //changed!!!
        
        geocoder.reverseGeocodeLocation(myLocation) { (placemarks, error) in
            // Process Response
            self.processResponse(withPlacemarks: placemarks, error: error)
        }
        
        
        
    }
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        // Update View
        
        if let error = error {
            print("Unable to Reverse Geocode Location (\(error))")
            postLocation.text = ""
            
        } else {
            if let placemarks = placemarks, let placemark = placemarks.first {
                postLocation.text = placemark.compactAddress
            } else {
                postLocation.text = ""
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
        fourSpotButton.layer.cornerRadius = 4
        fourSpotButton.layer.borderColor = UIColor.lightGray.cgColor
        sixSpotButton.layer.cornerRadius = 4
        sixSpotButton.layer.borderColor = UIColor.lightGray.cgColor
        eightSpotButton.layer.cornerRadius = 4
        eightSpotButton.layer.borderColor = UIColor.lightGray.cgColor
        
        cookButton.layer.cornerRadius = 4
        cookButton.layer.borderColor = UIColor.lightGray.cgColor
        cleanupButton.layer.cornerRadius = 4
        cleanupButton.layer.borderColor = UIColor.lightGray.cgColor
        groceriesButton.layer.cornerRadius = 4
        groceriesButton.layer.borderColor = UIColor.lightGray.cgColor
        
        
        datePicker.minimumDate = Date()
        datePicker.setValue(UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1), forKey: "textColor")
        
        postTitle.delegate = self
        postLocation.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fourSpotsClicked(_ sender: Any) {
        spots = 4
        fourSpotButton.layer.borderWidth = 2
        sixSpotButton.layer.borderWidth = 0
        eightSpotButton.layer.borderWidth = 0
    }
    @IBAction func sixSpotsClicked(_ sender: Any) {
        spots = 6
        fourSpotButton.layer.borderWidth = 0
        sixSpotButton.layer.borderWidth = 2
        eightSpotButton.layer.borderWidth = 0
        
    }
    @IBAction func eightSpotsClicked(_ sender: Any) {
        spots = 8
        fourSpotButton.layer.borderWidth = 0
        sixSpotButton.layer.borderWidth = 0
        eightSpotButton.layer.borderWidth = 2
        
    }
    @IBAction func cookClicked(_ sender: Any) {
        role = "cooks"
        cookButton.layer.borderWidth = 2
        cleanupButton.layer.borderWidth = 0
        groceriesButton.layer.borderWidth = 0
    }
    
    @IBAction func cleanupClicked(_ sender: Any) {
        role = "cleanup"
        cookButton.layer.borderWidth = 0
        cleanupButton.layer.borderWidth = 2
        groceriesButton.layer.borderWidth = 0
    }
    @IBAction func groceriesClicked(_ sender: Any) {
        role = "groceries"
        cookButton.layer.borderWidth = 0
        cleanupButton.layer.borderWidth = 0
        groceriesButton.layer.borderWidth = 2
    }
    
    @IBAction func onSendPressed(_ sender: UIButton) {
        if let title = postTitle.text, title != "", let location = postLocation.text, location != "", let spotsChosen = spots, spots != nil, let roleChosen = role, role != nil  {
            print("creating post")
            let time = datePicker.date
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, h:mm a"
            
            let readableTime = formatter.string(from: time)
            
            
            
            let userPost = Database.database().reference().child("posts").childByAutoId()
            
            let post: Dictionary<String, AnyObject> = [
                "title": title as AnyObject,
                "mealTime": readableTime as AnyObject,
                "location": location as AnyObject,
                "initialSpots": spotsChosen as AnyObject,
                "spotsLeft": spotsChosen - 1 as AnyObject,
                "postCreator": UserDefaults.standard.value(forKey: "uid") as AnyObject,
                "postID": userPost.key as AnyObject,
                "\(roleChosen)": [UserDefaults.standard.value(forKey: "uid") as AnyObject: ["name": UserDefaults.standard.value(forKey: "name") as AnyObject] as NSDictionary] as NSDictionary
                
                
                
            ]
            userPost.setValue(post)
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func onBackPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.postTitle.resignFirstResponder()
        self.postLocation.resignFirstResponder()
        return true
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
