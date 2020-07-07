//
//  DetailsViewController.swift
//  Simple Enrollment
//
//  Created by Alexander Roca on 7/4/20.
//  Copyright © 2020 Alexander Roca. All rights reserved.
//

import UIKit
import SDWebImage

class DetailsViewController: UIViewController {
    

    var enrollment: EnrollmentInfo?
    
    @IBOutlet weak var idNoLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idNoLabel.text = enrollment?.idNo
        firstNameLabel.text = enrollment?.firstName
        lastNameLabel.text = enrollment?.lastName
        mobileLabel.text = enrollment?.mobile
        addressLabel.text = enrollment?.address
        avatarImage.sd_setImage(with: URL(string: enrollment!.imageUrl), placeholderImage: UIImage(named: "avatar.png"))
    }
    
    @IBAction func deleteItem(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to delete", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            WebService.delete(idNo: self.enrollment!.idNo, completion: { response in
                NSLog("\(response)")
                if(response.success == "true") {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addVC = segue.destination as? AddViewController {
            addVC.enrollment = enrollment
        }
    }
}
