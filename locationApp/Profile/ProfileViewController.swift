//
//  ProfileViewController.swift
//  locationApp
//
//  Created by Ang Wei Hao Desmond on 23/9/17.
//  Copyright © 2017 desmond.ang.a0093896H. All rights reserved.
//

import UIKit
import FirebaseStorage

class ProfileViewController: UIViewController, UINavigationControllerDelegate {

    let imagePicker = UIImagePickerController()
    var didUpdateProfileImage = false

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!

    @IBAction func updateProfileImagePressed(_ sender: Any) {
        if !didUpdateProfileImage {
            self.showAlert(message: "Please upload a photo")
            return
        }

        let imageDataOptional = UIImagePNGRepresentation(self.profileImage.image!)
        let emailOptional = self.emailTextField.text

        guard let email = emailOptional, let imageData = imageDataOptional else {
            self.showAlert(message: "An error occurred")
            return
        }

        let uploadTask = ImagesController.uploadProfileImage(email: email, imageData: imageData)
        uploadTask.observe(.success) { snapshot in
            // Upload completed successfully
            self.showAlert(message: "Upload successful")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.isEnabled = false
        phoneTextField.isEnabled = false

        imagePicker.delegate = self
        let profileUpdateTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTap))
        profileImage.addGestureRecognizer(profileUpdateTapGesture)

        guard let userEmail = AuthController.getCurrentUser()?.email else {
            fatalError("User should be logged in")
        }

        AuthController.fetchUser(email: userEmail, successHandler: { (user) in
            self.emailTextField.text = user.email
            self.phoneTextField.text = user.phone

            ImagesController.loadProfileImage(email: user.email, imageView: self.profileImage)

        }, errorHandler: { (error) in
            print(error.localizedDescription)
        })
    }

}

extension ProfileViewController {
    func handleProfileImageTap(tapGestureRecognizer: UITapGestureRecognizer) {
        //Photos
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        imagePicker.modalPresentationStyle = .popover
        self.present(imagePicker, animated: true, completion: nil)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate {
    func imagePickerController(didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage 
        profileImage.contentMode = .scaleAspectFit
        profileImage.image = chosenImage
        self.didUpdateProfileImage = true
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel() {
        dismiss(animated: true, completion: nil)
    }
}
