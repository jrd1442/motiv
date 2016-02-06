//
//  ImageController.swift
//  motiv
//
//  Created by Julio Espinal on 2/4/16.
//  Copyright © 2016 Julio Espinal. All rights reserved.
//


import UIKit

class ImageController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var contIdx: Int = 0  // idx into my controller array
    var imageIdx: Int = 0 // idx into the images array, duh
    var name: String = "" // for debug, mostly
    
}

