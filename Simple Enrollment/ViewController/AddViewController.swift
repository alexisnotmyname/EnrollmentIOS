//
//  AddViewController.swift
//  Simple Enrollment
//
//  Created by Alexander Roca on 7/5/20.
//  Copyright © 2020 Alexander Roca. All rights reserved.
//

import UIKit
import SDWebImage

class AddViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var enrollment: EnrollmentInfo?
    
    @IBOutlet weak var idNoTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idNoRequiredLabel: UILabel!
    @IBOutlet weak var firstNameRequiredLabel: UILabel!
    @IBOutlet weak var lastNameRequiredLabel: UILabel!
    
    var pickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI() {
        idNoTextField.delegate = self
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        mobileTextField.delegate = self
        addressTextField.delegate = self
        pickerController.delegate = self
        
        idNoTextField.text = enrollment?.idNo
        firstNameTextField.text = enrollment?.firstName
        lastNameTextField.text = enrollment?.lastName
        mobileTextField.text = enrollment?.mobile
        addressTextField.text = enrollment?.address
        if((enrollment?.imageUrl) != nil) {
            imageView.sd_setImage(with: URL(string:enrollment!.imageUrl), placeholderImage: UIImage(named: "avatar.png"))
        }
        
        saveButton.layer.cornerRadius = saveButton.frame.size.height / 2
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddViewController.imageTapped(gesture:)))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imageView.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        if (gesture.view as? UIImageView) != nil {
            pickerController.sourceType = .camera
            present(pickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func saveSelected(_ sender: Any) {
        
        if lastNameTextField.text?.isEmpty ?? true {
            lastNameTextField.becomeFirstResponder()
            lastNameRequiredLabel.isHidden = false
        } else {
            lastNameRequiredLabel.isHidden = true
        }
        
        if firstNameTextField.text?.isEmpty ?? true {
            firstNameTextField.becomeFirstResponder()
            firstNameRequiredLabel.isHidden = false
        } else {
            firstNameRequiredLabel.isHidden = true
        }
        
        if idNoTextField.text?.isEmpty ?? true {
            idNoTextField.becomeFirstResponder()
            idNoRequiredLabel.isHidden = false
        } else {
            idNoRequiredLabel.isHidden = true
        }
        
        if idNoTextField.text != "" && firstNameTextField.text != "" && lastNameTextField.text != ""{
            self.showLoader()
            let img_data = imageView.image?.jpegData(compressionQuality: 0)
            let jsonObject: [String: Any] = [
                "idNo": idNoTextField.text as Any,
                "firstName": firstNameTextField.text as Any,
                "lastName":lastNameTextField.text as Any,
                "mobile": mobileTextField.text as Any,
                "address": addressTextField.text as Any
            ]
            WebService.enroll(data_img: img_data, json: jsonObject, completion: { response in
                NSLog("RESPONSE \(response)")
                self.dismissLoader()
                if(response.success == "true") {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
