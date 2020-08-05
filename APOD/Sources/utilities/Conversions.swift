//
//  Conversions.swift
//  APOD
//
//  Created by Ibm Mac on 4/08/20.
//  Copyright © 2020 harry. All rights reserved.
//

import Foundation
import UIKit

class Conversions : Operation {
    
    var outputImage : UIImage?
    
    override func main() {
        print("Open Dependency Image")
        if let dependency = dependencies.first as? NetworkingClass, let data = dependency.result, let image = UIImage(data: data){
            ManagerAPOD.shared.listImage.append(image)
        }
    }
}
