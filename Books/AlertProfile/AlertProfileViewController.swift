//
//  AlertProfileViewController.swift
//  Books
//
//  Created by alumno on 25/12/2019.
//  Copyright © 2019 Carlos. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import MessageUI
class AlertProfileViewController: UIViewController, MFMailComposeViewControllerDelegate{
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let profileView = ProfileViewController()
    let profileModel = ProfileModel()
    let ref = Database.database().reference()
    var author: String = ""
       var titleText: String = ""
       var imagen: UIImage!
       var isbn:String = ""
       var user:String = ""
       var correo:String = ""
    var imageURL:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
        
        // Do any additional setup after loading the view.
    }
    func setUp(){
        titleLabel.text = titleText
        authorLabel.text = author
        image.image = imagen
    }
    @IBAction func backTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func wantItTappet(_ sender: Any) {
        profileModel.wantIt(author: author, image: imageURL, user: user, isbn: isbn, title: titleText, correo: correo) { (error) in
                   if(!error){
                       self.dismiss(animated: true)

                   }

               }

        
    }
    @IBAction func contactTapped(_ sender: Any) {
    let mailComposeViewController = configuredMailComposeViewController(to: correo, title: titleText)
            if MFMailComposeViewController.canSendMail() {
                self.present(mailComposeViewController, animated: true, completion: nil)
            }else{
        }
    }

    
    func configuredMailComposeViewController(to:String,title:String) -> MFMailComposeViewController {
            let mailComposerVC = MFMailComposeViewController()
            mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
    
            mailComposerVC.setToRecipients([to])
            mailComposerVC.setSubject("Interesado en: \(self.titleText)")
        mailComposerVC.setMessageBody("", isHTML: true)
    
            return mailComposerVC
        }
    
    
       // MARK: MFMailComposeViewControllerDelegate Method
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
           controller.dismiss(animated: true, completion: nil)
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
