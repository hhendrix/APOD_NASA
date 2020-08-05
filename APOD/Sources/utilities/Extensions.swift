//
//  Extensions.swift
//  APOD
//
//  Created by Ibm Mac on 4/08/20.
//  Copyright © 2020 harry. All rights reserved.
//

import UIKit


extension UIImageView {
    
    func donwloadedFrom(link:String, contentMode mode:UIView.ContentMode = .scaleAspectFit){
        guard let url = URL(string:link) else {return}
        donwloadedFrom(url: url,contentMode:mode)
    }
    
    func donwloadedFrom(url:URL, contentMode mode:UIView.ContentMode = .scaleAspectFit){
        
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in

            if error != nil {
                print(error ?? "No Error")
                return
            }
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
  
    }
    
}


extension UIView {
    
    @IBInspectable
    var cornerRadiusView: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
}



