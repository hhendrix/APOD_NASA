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
    @IBOutlet weak var titleMainLabel: UILabel!
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var textViewDescription: UITextView!
    
    @IBOutlet weak var activityIndicatorDetail: UIActivityIndicatorView!
    
    var dateSelected = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getDataSelected()
        
        self.activityIndicatorDetail.startAnimating()
    }
    
    
    
    func getDataSelected(){
        ManagerAPOD.shared.getImageAPOD(fechaInicial: dateSelected, fechaFinal: dateSelected) { listApods in
            if let apodDay = listApods.first {
                let deadlineTime = DispatchTime.now() + .seconds(1)
                DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                    self.imageDetail.donwloadedFrom(link: apodDay.url)
                    self.imageDetail.contentMode = .scaleAspectFill
                    
                    let dateFormatterGet = DateFormatter()
                    dateFormatterGet.dateFormat = "yyyy-MM-dd"
                    let dateFormatterPrint = DateFormatter()
                    dateFormatterPrint.dateFormat = "MMM d, yyyy"
                    dateFormatterPrint.locale = Locale(identifier: "es_CO")
                    if let date = dateFormatterGet.date(from: String(describing: apodDay.date)) {
                        self.dateLabel.text =  "Publication Date:   \(dateFormatterPrint.string(from: date))"
                    }
                    
                    self.textViewDescription.text = apodDay.explanation
                    self.titleMainLabel.text = apodDay.title
                    
                    self.activityIndicatorDetail.stopAnimating()
                    self.activityIndicatorDetail.isHidden = true
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
