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
    
    var listAPODS : [APOD]?
    var listImage = [UIImage]()
    var listAPOS : [APODStruct]?
    
    func getImageAPOD(fechaInicial:String,fechaFinal:String, callback: @escaping ([APODStruct]) -> Void) {
        
        let queue = OperationQueue()
        
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
            
            //            let getImageAPODOperation = NetworkingClass(url: url)
            //            getImageAPODOperation.addDependency(getDataUrlOperation)
            //
            //
            //            queue.addOperations([getDataUrlOperation,getImageAPODOperation], waitUntilFinished: true)
            //
            //            print("Termina primer Llamado")
            
            //            let queueImages = OperationQueue()
            //
            //            if let apods = getImageAPODOperation.listAPOS {
            //                for pod in apods {
            //                    if let url = URL(string: pod.url){
            //                        let imageLoad = NetworkingClass(url: url)
            //                        let convertImageOperation = Conversions()
            //                        convertImageOperation.addDependency(imageLoad)
            //                        queueImages.addOperations([imageLoad, convertImageOperation], waitUntilFinished: true)
            //                    }
            //                }
            //            }
            //print(convertImageOperation.outputImage ?? "Nada")
        }
    }
    
}
