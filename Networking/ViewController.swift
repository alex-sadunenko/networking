//
//  ViewController.swift
//  Networking
//
//  Created by Alex on 01.08.2020.
//  Copyright © 2020 Alex Sadunenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader.isHidden = true
        loader.hidesWhenStopped = true
        
        downloadImage()
        
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        downloadImage()
    }
    
    func downloadImage() {
        
        label.isHidden = true
        loader.isHidden = false
        loader.startAnimating()
        guard let url = URL(string: "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg") else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data, let myImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.loader.stopAnimating()
                    self.image.image = myImage
                }
            }
        }.resume()
        
    }
    
}

