//
//  HomeViewController.swift
//  Login
//
//  Created by aluno on 17/09/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    var username: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let username = username else {
            return
        }
        
        welcomeLabel.text = "Welcome \(username)"
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.post(Notification(name: Notification.Name("signedOut")))
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
