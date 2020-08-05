//
//  ViewController.swift
//  APOD
//
//  Created by Ibm Mac on 31/07/20.
//  Copyright © 2020 harry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btnShowViews: UIButton!
    @IBOutlet weak var imageMail: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicatorImage: UIActivityIndicatorView!
    @IBOutlet weak var labelDate: UITextField!
    
    
    @IBOutlet weak var selectedDay: UIButton!
    
    
    var dataDetail:APODStruct?
    private var dateCurrent = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //LoadingNasa.shared.showLoader()
        self.getCurrentDate()
        
        let gestureRecognizerImage = UITapGestureRecognizer(target: self, action: #selector(selectImageForOpenAPod))
        imageMail.addGestureRecognizer(gestureRecognizerImage)
        imageMail.isUserInteractionEnabled = true
        
        self.getImageDay()
        
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChange(sender:)), for: .valueChanged)
        labelDate.inputView = datePicker
        
        
        self.activityIndicatorImage.startAnimating()
    }
    
    
    @IBAction func OpenViewCOntroller(_ sender: UIButton) {
        print("Open Controller")
    }
    
    
    func getImageDay(){
        ManagerAPOD.shared.getImageAPOD(fechaInicial: dateCurrent, fechaFinal: dateCurrent) { listApods in
            if let apodDay = listApods.first {
                let deadlineTime = DispatchTime.now() + .seconds(1)
                DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                    self.imageMail.donwloadedFrom(link: apodDay.url)
                    self.imageMail.contentMode = .scaleAspectFill
                    self.titleLabel.text = apodDay.title
                    self.activityIndicatorImage.stopAnimating()
                    self.activityIndicatorImage.isHidden = true
                    
                }
            }
        }
        
    }
    
    func getCurrentDate(){
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        self.dateCurrent = format.string(from: date)
    }
    
    
    @IBAction func openControlDate(_ sender: UIButton) {
        //performSegue(withIdentifier: "toDetailSegue", sender: nil)
        view.endEditing(true)
    }
    
    @objc func datePickerValueChange(sender: UIDatePicker){
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let formattedDate = format.string(from: sender.date)
        
        self.labelDate.text = formattedDate
        
        
    }
    
    @objc func selectImageForOpenAPod(){
        performSegue(withIdentifier: "toDetailSegue", sender: self.dateCurrent)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailSegue" {
            if let destinationVC = segue.destination as? DetailViewController {
                if self.labelDate.text != "" {
                    destinationVC.dateSelected = self.labelDate.text!
                }
                else{
                    destinationVC.dateSelected = self.dateCurrent
                }
            }
        }
    }
    
    
    
    
    
}

