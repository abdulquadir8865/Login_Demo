//
//  loginViewController.swift
//  Login_Demo
//
//  Created by  Abdul Quadir on 09/03/24.
//

import UIKit

class loginViewController: UIViewController {

    
    
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
//    btn outlet
    @IBOutlet weak var gBtn: UIButton!
    @IBOutlet weak var fBtn: UIButton!
    @IBOutlet weak var LgnBtn: UIButton!
    
    
    var iconClick = false
    let imgIcon =     UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // textfield border
        emailTxt.layer.cornerRadius = 10
        passwordTxt.layer.cornerRadius = 10
        emailTxt.clipsToBounds = true
        passwordTxt.clipsToBounds = true
        LgnBtn.layer.cornerRadius = 20
        // button border
        gBtn.layer.borderWidth = 1.0
        gBtn.layer.borderColor = UIColor.red.cgColor
        gBtn.layer.cornerRadius = 10.0
        fBtn.layer.borderWidth = 1.0
        fBtn.layer.borderColor = UIColor.systemRed.cgColor
        fBtn.layer.cornerRadius = 10.0

        
        // img icon
        
        
        
        imgIcon.image = UIImage(named: "close")
        let contentview = UIView()
        contentview.addSubview(imgIcon)
        
        let iconSize = CGSize(width: 24, height: 24)
        imgIcon.frame = CGRect(x: 0, y: 0, width: iconSize.width, height: iconSize.height)
     
        contentview.addSubview(imgIcon)
        contentview.frame = CGRect(x: 0, y: 0, width: iconSize.width, height: iconSize.height)

        passwordTxt.rightView = contentview
        passwordTxt.rightViewMode = .always
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGesture:)))

        imgIcon.isUserInteractionEnabled = true
        imgIcon.addGestureRecognizer(tapGesture)
        
    }
    
    
    @objc func imageTapped(tapGesture:UITapGestureRecognizer){
        let tapImg = tapGesture.view as! UIImageView
        
        if iconClick {
            iconClick = false
            tapImg.image = UIImage(named: "open")
            passwordTxt.isSecureTextEntry = false
        }else{
            iconClick = true
            tapImg.image = UIImage(named: "close")
            passwordTxt.isSecureTextEntry = true
        }
    }
    

    
    // alert use and second vc to navigation
    @IBAction func login2Vc(_ sender: Any) {
        guard let email = emailTxt.text, !email.isEmpty, isValidEmail(email) else {
            let errorAlert = UIAlertController(title: "Error", message: "Please enter a valid email", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            errorAlert.addAction(okAction)
            present(errorAlert, animated: true, completion: nil)
            return
        }

        guard let password = passwordTxt.text, !password.isEmpty, isValidPassword(password) else {
            let errorAlert = UIAlertController(title: "Error", message: "Please enter a valid password", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            errorAlert.addAction(okAction)
            present(errorAlert, animated: true, completion: nil)
            return
        }

        let successAlert = UIAlertController(title: "Login", message: "You have successfully logged in!", preferredStyle: .alert)

        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
            let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
            self.navigationController?.pushViewController(secondVC, animated: true)
        }

        successAlert.addAction(action)

        present(successAlert, animated: true, completion: nil)

        
    }

    // validate email format
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    // validate password format
    func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6
    }

    
    

}
