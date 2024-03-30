//
//  ViewController.swift
//  Login_Demo
//
//  Created by  Abdul Quadir on 09/03/24.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var btn1: UIButton!
    
    @IBOutlet weak var btn2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        btn1.layer.cornerRadius = 20
        btn2.layer.cornerRadius = 20

    }

    
    @IBAction func LoginBtn(_ sender: Any) {
        print("login")
        
        let alert = UIAlertController(title: "Login", message: "You are entered into login", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Login Page", style: .default) { (action) in
            // Navigate to the second viewcontroller
            let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
            self.navigationController?.pushViewController(secondVC, animated: true)
        }
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func registerBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Register", message: "Server no response", preferredStyle: .alert)
           
           let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           alert.addAction(okAction)
           
           present(alert, animated: true, completion: nil)
    }
    
}

