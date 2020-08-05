//
//  APODStruct.swift
//  APOD
//
//  Created by Ibm Mac on 4/08/20.
//  Copyright © 2020 harry. All rights reserved.
//

import Foundation
import UIKit

struct APODStruct: Codable {
    var date: String
    var explanation : String
    var title : String
    var url : String
}

struct APOD {
    var date: String
    var explanation : String
    var hdurl : String
    var title : String
    var url : String
    var image : UIImage
}
