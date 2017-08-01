//
//  SignUpViewController.swift
//  ParseStarterProject
//
//  Created by Paula Dozsa on 5/2/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBAction func signUp(sender: AnyObject) {
        PFUser.currentUser()?["interestedInWomen"] = interestedInWomen.on
        PFUser.currentUser()?.save()
    }
    @IBOutlet weak var interestedInWomen: UISwitch!
    @IBOutlet weak var userImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        /*let urlArray=["http://cdn.petpictures.xyz/2015/08/18/super-cute-kittens-15-pictures.jpg",
                      "http://tailandfur.com/wp-content/uploads/2016/01/40-Beautiful-and-Cute-Kitten-Pictures-2.jpg",
                      "https://i.ytimg.com/vi/6sta6Gkpgcw/maxresdefault.jpg",
                      "http://millionpictureblog.com/wp-content/uploads/2015/12/Cute-Kittens-7.jpg",
                      "https://s-media-cache-ak0.pinimg.com/736x/3e/31/12/3e31126ace109a6bd5b3e4329a5c4219.jpg"]
        var counter = 11
        for url in urlArray {
            let nsUrl = NSURL(string: url)!
            if let data = NSData(contentsOfURL: nsUrl) {
                self.userImage.image = UIImage(data: data)
                let imageFile:PFFile = PFFile(data: data)
                var user:PFUser = PFUser()
                var username = "user\(counter)"
                user.username = username
                user.password = "pass"
                user["image"] = imageFile
                user["interestedInWomen"] = false
                user["gender"] = "male"
                counter+=1
                user.signUp()
            }
        }
        let urlArray2=["http://cdn.petpictures.xyz/2015/08/18/super-cute-kittens-15-pictures.jpg",
                      "http://tailandfur.com/wp-content/uploads/2016/01/40-Beautiful-and-Cute-Kitten-Pictures-2.jpg",
                      "https://i.ytimg.com/vi/6sta6Gkpgcw/maxresdefault.jpg",
                      "http://millionpictureblog.com/wp-content/uploads/2015/12/Cute-Kittens-7.jpg",
                      "https://s-media-cache-ak0.pinimg.com/736x/3e/31/12/3e31126ace109a6bd5b3e4329a5c4219.jpg"]
        var counter2 = 16
        for url in urlArray2 {
            let nsUrl = NSURL(string: url)!
            if let data = NSData(contentsOfURL: nsUrl) {
                self.userImage.image = UIImage(data: data)
                let imageFile:PFFile = PFFile(data: data)
                var user:PFUser = PFUser()
                var username = "user\(counter2)"
                user.username = username
                user.password = "pass"
                user["image"] = imageFile
                user["interestedInWomen"] = false
                user["gender"] = "female"
                counter2+=1
                user.signUp()
            }
        }*/
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, gender, email"])
        graphRequest.startWithCompletionHandler( {
            
            (connection, result, error) -> Void in
            
            if error != nil {
                
                print(error)
                
            } else if let result = result {
                
                print(result["email"])
                
                PFUser.currentUser()?["gender"] = result["gender"]
                PFUser.currentUser()?["name"] = result["name"]
                PFUser.currentUser()?["email"] = result["email"]
                
                PFUser.currentUser()?.save()
                
                let userId = result["id"] as! String
                
                let facebookProfilePictureUrl = "https://graph.facebook.com/" + userId + "/picture?type=large"
                
                if let fbpicUrl = NSURL(string: facebookProfilePictureUrl) {
                    
                    if let data = NSData(contentsOfURL: fbpicUrl) {
                        
                        self.userImage.image = UIImage(data: data)
                        
                        let imageFile:PFFile = PFFile(data: data)
                        
                        PFUser.currentUser()?["image"] = imageFile
                        
                        PFUser.currentUser()?.save()
                        
                    }
                    
                }
                
            }
            
        })
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
