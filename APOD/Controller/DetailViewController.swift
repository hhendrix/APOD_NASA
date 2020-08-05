//
//  DetailViewController.swift
//  APOD
//
//  Created by Ibm Mac on 4/08/20.
//  Copyright © 2020 harry. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    var dateSelected = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getDataSelected()
    }
    
    
    
    func getDataSelected(){
        ManagerAPOD.shared.getImageAPOD(fechaInicial: dateSelected, fechaFinal: dateSelected) { listApods in
            if let apodDay = listApods.first {
                let deadlineTime = DispatchTime.now() + .seconds(1)
                DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                    self.imageDetail.donwloadedFrom(link: apodDay.url)
                    self.imageDetail.contentMode = .scaleAspectFill
                    self.dateLabel.text = apodDay.date
                    self.descriptionLabel.text = apodDay.explanation
                    self.title = apodDay.title
                    
                }
            }
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
