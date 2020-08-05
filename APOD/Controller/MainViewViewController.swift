//
//  MainViewViewController.swift
//  APOD
//
//  Created by Ibm Mac on 4/08/20.
//  Copyright © 2020 harry. All rights reserved.
//

import UIKit

class MainViewViewController: UIViewController {
    
    @IBOutlet weak var scrollDetailApod: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //LoadingNasa.shared.showLoader()
        let managerImage = ManagerAPOD()
        //managerImage.getImageAPOD()
        let widthView = self.view.frame.width
        
        self.scrollDetailApod.delegate = self
        
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let dateCurrent = format.string(from: date)
        
        var dateComponent = DateComponents()
        dateComponent.day = -8
        
        let pastDate = Calendar.current.date(byAdding: dateComponent, to: date)
        let pastDateString = format.string(from: pastDate!)
        
        ManagerAPOD.shared.getImageAPOD(fechaInicial: pastDateString, fechaFinal: dateCurrent) { listApods in
            
            let deadlineTime = DispatchTime.now() + .seconds(1)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                
                self.managerDataAPods(scrollView: self.scrollDetailApod, widthView, listAPODSData:listApods)
                print("Carga Imagenes: ", listApods.count)
                
                // Set the scrollView contentSize
                self.scrollDetailApod.contentSize = CGSize(width: self.scrollDetailApod.frame.width * CGFloat(listApods.count),
                                                           height: self.scrollDetailApod.frame.height)
                
                // Ensure that the pageControl knows the number of pages
                self.pageControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                self.pageControl.addTarget(self, action: #selector(self.pageControlSelectionAction(_:)), for: .touchUpInside)
                self.pageControl.numberOfPages = listApods.count
            }
            
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    func managerDataAPods(scrollView control:UIScrollView, _ vistaWidth:CGFloat, listAPODSData:[APODStruct]){
        var slideList = [DetailApods]()
        var valueMaxHeight = CGFloat(435)
        for slide in listAPODSData {
            
            
            if let controlSlide:DetailApods = Bundle.main.loadNibNamed("ViewImages", owner: self, options: nil)?.first as? DetailApods {
                
                let urlImage = slide.url
                controlSlide.imageAPOD.donwloadedFrom(link: urlImage)
                controlSlide.imageAPOD.contentMode = .scaleAspectFill
                
                
                controlSlide.dateCreationLabel.text = slide.date
                controlSlide.titleLabel.text = slide.title
                controlSlide.titleLabel.sizeToFit()
                controlSlide.explicationLabel.text = slide.explanation
                controlSlide.explicationLabel.sizeToFit()
                
                let heightControl = 380 + controlSlide.titleLabel.frame.height  + controlSlide.explicationLabel.frame.height
                
                if heightControl >= valueMaxHeight {
                    valueMaxHeight = heightControl
                }
                
                slideList.append(controlSlide)
            }
        }
        
        control.frame = CGRect(x: 0, y: 0, width: vistaWidth, height: valueMaxHeight)
        control.contentSize = CGSize(width: vistaWidth * CGFloat(slideList.count), height: valueMaxHeight)
        control.isPagingEnabled = true
        
        for i in 0 ..< slideList.count {
            slideList[i].frame = CGRect(x: vistaWidth * CGFloat(i), y: 0, width: vistaWidth, height: valueMaxHeight + 300)
            control.addSubview(slideList[i])
        }
        
        
        
    }
    
    
    // MARK: Eventos Controles
    
    @IBAction func pageSelect(_ sender: Any) {
        guard let pageControl: UIPageControl = sender as? UIPageControl else {
            return
        }
        
        //newsManager.shared.indexSelectNews = pageControl.currentPage
        
        scrollToIndex(index: pageControl.currentPage)
    }
    
    // MARK: Functions Controller
    private func scrollToIndex(index: Int) {
        let pageWidth: CGFloat = scrollDetailApod.frame.width
        let slideToX: CGFloat = CGFloat(index) * pageWidth
        
        scrollDetailApod.scrollRectToVisible(CGRect(x: slideToX, y:0, width:pageWidth, height:scrollDetailApod.frame.height), animated: true)
    }
    
    
    @objc func pageControlSelectionAction(_ sender: UIPageControl) {
        scrollToIndex(index: sender.currentPage )
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

extension MainViewViewController : UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        //let currentPage:CGFloat = floor(5000)+1
        pageControl.currentPage = Int(currentPage)
        //newsManager.shared.indexSelectNews = Int(currentPage)
    }
}
