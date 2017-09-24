//
//  ImagesController.swift
//  locationApp
//
//  Created by Ang Wei Hao Desmond on 24/9/17.
//  Copyright © 2017 desmond.ang.a0093896H. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseStorageUI

class ImagesController {

    static let storageRef = Storage.storage().reference()
    static let imagesRef = storageRef.child("images")

    static func uploadProfileImage(email: String, imageData: Data) -> StorageUploadTask {
        let sanitizedEmail = email.replacingOccurrences(of: ".", with: "")
        let imageRef = imagesRef.child("/\(sanitizedEmail)/profileImage/image.png")
        let uploadTask = imageRef.putData(imageData, metadata: nil)
        return uploadTask
    }

    static func loadProfileImage(email: String, imageView: UIImageView) {
        let sanitizedEmail = email.replacingOccurrences(of: ".", with: "")
        let imageRef = imagesRef.child("/\(sanitizedEmail)/profileImage/image.png")
        let placeholderImage = UIImage(named: "no_photo")

        imageView.sd_setImage(with: imageRef, placeholderImage: placeholderImage)
    }
}
