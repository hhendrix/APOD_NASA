//
//  ManagerAPOD.swift
//  APOD
//
//  Created by Ibm Mac on 4/08/20.
//  Copyright © 2020 harry. All rights reserved.
//

import Foundation
import UIKit

class ManagerAPOD {
    
    static let shared = ManagerAPOD()
    
    var listImage = [UIImage]()
    var listAPOS : [APODStruct]?
    
    func getImageAPOD(fechaInicial:String,fechaFinal:String, callback: @escaping ([APODStruct]) -> Void) {
        
        var urlAPOD =  APODServices.URLApod.replacingOccurrences(of: "start_date1", with: fechaInicial)
        urlAPOD =  urlAPOD.replacingOccurrences(of: "end_date1", with: fechaFinal)
        if let url = URL(string: urlAPOD){
            
            let getDataUrlOperation = NetworkingClass(url: url)
            
            getDataUrlOperation.network(url: url) { data in
                let decoder = JSONDecoder()
                if let postJSON = try? decoder.decode([APODStruct].self, from:data){
                    self.listAPOS = postJSON
                    callback(postJSON)
                    print("Fin Dependency")
                }
            }
        }
    }
    
}
