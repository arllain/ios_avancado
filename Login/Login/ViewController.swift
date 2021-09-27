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
    private var hasSignedIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if hasSignedIn {
            hasSignedIn = false
            presentAlert(with: "you are signed  out")
        }
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        guard let missingField = validate() else {
            performSegue(withIdentifier: Segues.signedIn.rawValue, sender: self)
            return
        }
        
        presentErrorAlert(with: missingField)
    }
    
    @IBAction func signInButtonPressedXibs(_ sender: UIButton) {
        let myViewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
        self.present(myViewController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.signedIn.rawValue {
            let destinationController = segue.destination as? HomeViewController
            destinationController?.username = usernameTextField.text
            hasSignedIn = true
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

    func presentAlert(with message: String) {
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
}

