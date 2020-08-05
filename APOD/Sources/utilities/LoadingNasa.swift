//
//  LoadingNasa.swift
//  APOD
//
//  Created by Ibm Mac on 4/08/20.
//  Copyright © 2020 harry. All rights reserved.
//

import UIKit

class LoadingNasa : UIView {
    
    static let shared = LoadingNasa()
    
    var viewColor : UIColor = .black
    var viewColorError : UIColor = .white
    var setAlpha : CGFloat = 0.2
    var gifName: String = ""
    var isErrorConexion = false
    
    lazy var transparentView: UIView = {
        let transparentView   = UIView(frame :UIScreen.main.bounds)
        transparentView.backgroundColor = viewColor.withAlphaComponent(setAlpha)
        //        transparentView.backgroundColor =  UIColor(red: 0, green: 114/255, blue: 198/255, alpha: 1.0)
        //        transparentView.backgroundColor =  .white
        transparentView.isUserInteractionEnabled = true
        return transparentView
    }()
    
    
    lazy var transparentViewError: UIView = {
        let transparentView   = UIView(frame :UIScreen.main.bounds)
        transparentView.backgroundColor = viewColor.withAlphaComponent(0.3)
        transparentView.isUserInteractionEnabled = true
        return transparentView
    }()
    
    lazy var imageLoaging: UIImageView  = {
        
        let imageLoaging  = UIImageView(frame:CGRect(x:0,y:0,width:40, height:40))
        imageLoaging.contentMode = .scaleAspectFit
        imageLoaging.center = transparentView.center
        imageLoaging.image = UIImage(named: "LogoNasa")
        
        return imageLoaging
        
    }()
    
    lazy var textErrorConection : UILabel = {
        
        let textMessageConection = UILabel(frame: CGRect(x: 10, y: 30, width: UIScreen.main.bounds.width - 70, height: 80.0))
        
        textMessageConection.font = UIFont(name: "Roboto-Bold", size: 18.0)
        //textMessageConection.textColor = UIColor(red: 0, green: 114/255, blue: 198/255, alpha: 1.0)
        textMessageConection.textColor = .black
        textMessageConection.textAlignment = .center
        textMessageConection.numberOfLines = 0
        textMessageConection.adjustsFontSizeToFitWidth = true
        textMessageConection.minimumScaleFactor = 0.5
        
        return textMessageConection
    }()
    
    
    func showLoader(){
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = Double.pi * 2
        rotation.duration = 3.0 // or however long you want ...
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        imageLoaging.layer.add(rotation, forKey: "rotationAnimation")
        
        
        self.addSubview(transparentView)
        self.transparentView.addSubview(imageLoaging)
        self.transparentView.bringSubviewToFront(self.imageLoaging)
        
        let keyWindow = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
        .filter({$0.isKeyWindow}).first
        
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        
       // window?.addSubview(transparentView)
        keyWindow?.addSubview(transparentView)
        //UIApplication.shared.keyWindow?.addSubview(transparentView)
    }
    
    func hideLoader(){
        self.transparentView.removeFromSuperview()
    }
    
    
    // Mark: - Mostrar Error Conexion
    func showErrorConexion(){
        
        self.isErrorConexion = true
        let uiViewTextContainer = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 50, height: 140.0))
        uiViewTextContainer.backgroundColor = .white
        uiViewTextContainer.center   = transparentViewError.center
        // uiViewTextContainer.cornerRadiusView = 5.0
        //textErrorConection.center = uiViewTextContainer.center
        
        
        textErrorConection.text = "Por favor verifique su conexión a internet e intente de nuevo"
        
        uiViewTextContainer.addSubview(textErrorConection)
        
        self.addSubview(transparentViewError)
        self.transparentViewError.addSubview(uiViewTextContainer)
        self.transparentViewError.bringSubviewToFront(uiViewTextContainer)
        UIApplication.shared.keyWindow?.addSubview(transparentViewError)
    }
    
    
    func hideError(){
        self.isErrorConexion = false
        self.transparentViewError.removeFromSuperview()
    }
}

