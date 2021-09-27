//
//  ViewController.swift
//  Login
//
//  Created by aluno on 17/09/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    //private var hasSignedIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNotification()
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        validateAndNavigateIfNeeded {
            self.performSegue(withIdentifier: Segues.signedIn.rawValue, sender: self)
        }
    }
    
    @IBAction func signInButtonPressedXibs(_ sender: UIButton) {
        validateAndNavigateIfNeeded {
            let xibViewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
            xibViewController.username = self.usernameTextField.text
            self.navigationController?.pushViewController(xibViewController, animated: true)
            // ou como modal
            //self.present(xibViewController, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.signedIn.rawValue {
            let destinationController = segue.destination as? HomeViewController
            destinationController?.username = usernameTextField.text
            //hasSignedIn = true
        }
    }
}

private extension ViewController {
    
    func presentErrorAlert(with missingField: String) {
        let alert = UIAlertController(title: "Error", message: "\(missingField) is required", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    func handleSignedOutEvent(with message: String) {
        usernameTextField.text = ""
        passwordTextField.text = ""
        let alert = UIAlertController(title: "Alert", message: "\(message)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    

    func validate() -> String? {
        if usernameTextField.text?.isEmpty == true {
            return "Username"
        }
        
        if passwordTextField.text?.isEmpty == true {
            return "Password"
        }
        
        return nil
    }
    
    func registerNotification(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(signedOutReceived),
                                               name: NSNotification.Name("signedOut"), object: nil)
   }
    
    @objc
    func signedOutReceived() {
        handleSignedOutEvent(with: "you are signed  out")
    }
    
    func validateAndNavigateIfNeeded(navigationCallBack: @escaping() -> Void){
        guard let missingField = validate() else {
            navigationCallBack()
            return
        }
        
        presentErrorAlert(with: missingField)
        
    }
        
}

