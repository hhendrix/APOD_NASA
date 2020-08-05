//
//  NetworkingClass.swift
//  APOD
//
//  Created by Ibm Mac on 4/08/20.
//  Copyright © 2020 harry. All rights reserved.
//

import Foundation
import UIKit

class NetworkingClass : AsyncOperation {
    let url : URL
    var result : Data?
    var listAPOS : [APODStruct]?
    
    init(url:URL){
        self.url = url
        super.init()
    }
    
    override func main() {
        
        if let dependency = dependencies.first as? NetworkingClass, let data = dependency.result {
            print("Open Dependency")
            let decoder = JSONDecoder()
            if let postJSON = try? decoder.decode([APODStruct].self, from:data){
                self.listAPOS = postJSON
                print("Fin Dependency")
                self.state = .Finished
            }
        }else{
            print("Open Url")
            network(url: url){ data in
                self.result = data
                print("Fin Open Url")
                self.state = .Finished
            }
        }
        
        
        
    }
    
    
    
    func network(url:URL, callback: @escaping (Data) -> Void){
        print("Open Conection")
        URLSession.shared.dataTask(with: url){ data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                if let error = error {
                    print("Error en la operacion:" , error)
                }
                self.state = .Finished
                return
            }
            print("Response Connectio:", response.statusCode)
            if response.statusCode == 200 {
                callback(data)
            }else {
                print("Error: \(response.statusCode)")
                self.state = .Finished
            }
            
        }.resume()
    }
}
