//
//  ViewControllerUtils.swift
//  PanicAlert
//
//  Created by NeoSOFT on 04/04/22.
//

import UIKit
//
// MARK: - ViewControllerUtils
//
class ViewControllerUtils {
    
    let containerView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.2)
        return view
    }()
    
    let loadingView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        
        let aiv = UIActivityIndicatorView()
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.style = UIActivityIndicatorView.Style.whiteLarge
        return aiv
    }()
    
    let loadingLabel: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Loading..."
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        return lbl
    }()
    
    func showLoader() {
        
        guard let window = UIApplication.shared.keyWindow else { return }
        
        window.addSubview(containerView)
        containerView.addSubview(loadingView)
        loadingView.addSubview(activityIndicatorView)
        loadingView.addSubview(loadingLabel)
        
        containerView.leftAnchor.constraint(equalTo: window.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: window.rightAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: window.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: window.bottomAnchor).isActive = true
        
        loadingView.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
        loadingView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        loadingView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        activityIndicatorView.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
        activityIndicatorView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        activityIndicatorView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        loadingLabel.leftAnchor.constraint(equalTo: loadingView.leftAnchor).isActive = true
        loadingLabel.rightAnchor.constraint(equalTo: loadingView.rightAnchor).isActive = true
        loadingLabel.bottomAnchor.constraint(equalTo: loadingView.bottomAnchor).isActive = true
        loadingLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        DispatchQueue.main.async {
            self.activityIndicatorView.startAnimating()
        }
    }
    
    func hideLoader() {
        
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorView.removeFromSuperview()
            self.loadingLabel.removeFromSuperview()
            self.loadingView.removeFromSuperview()
            self.containerView.removeFromSuperview()
        }
    }
   
}

//
// MARK: - ViewControllerUtils2
//
class ViewControllerUtils2 {
    
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    let loadingLabel = UILabel()
    
    func showLoader(_ uiView: UIView) {
        
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColor(white: 0, alpha: 0.2)
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 120, height: 120)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        
        loadingLabel.frame = CGRect(x: 0, y: 80, width: 120, height: 40)
        loadingLabel.text = "Loading..."
        loadingLabel.textAlignment = .center
        loadingLabel.textColor = .white
        loadingLabel.font = .systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        
        uiView.addSubview(container)
        container.addSubview(loadingView)
        loadingView.addSubview(activityIndicator)
        loadingView.addSubview(loadingLabel)
        
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideLoader() {
        
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
            self.loadingLabel.removeFromSuperview()
            self.loadingView.removeFromSuperview()
            self.container.removeFromSuperview()
        }
    }
}

//
// MARK: - ViewControllerUtilsForSaveData
//
class ViewControllerUtilsForSaveData {
    
    let containerView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.2)
        return view
    }()
    
    let loadingView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        
        let aiv = UIActivityIndicatorView()
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.style = UIActivityIndicatorView.Style.whiteLarge
        return aiv
    }()
    
    let loadingLabel: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Loading..."
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        return lbl
    }()
    
    func showLoader() {
        
        guard let window = UIApplication.shared.keyWindow else { return }
        
        window.addSubview(containerView)
        containerView.addSubview(loadingView)
        loadingView.addSubview(activityIndicatorView)
        loadingView.addSubview(loadingLabel)
        
        containerView.leftAnchor.constraint(equalTo: window.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: window.rightAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: window.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: window.bottomAnchor).isActive = true
        
        loadingView.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
        loadingView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        loadingView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        activityIndicatorView.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
        activityIndicatorView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        activityIndicatorView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        loadingLabel.leftAnchor.constraint(equalTo: loadingView.leftAnchor).isActive = true
        loadingLabel.rightAnchor.constraint(equalTo: loadingView.rightAnchor).isActive = true
        loadingLabel.bottomAnchor.constraint(equalTo: loadingView.bottomAnchor).isActive = true
        loadingLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //        DispatchQueue.main.async {
        self.activityIndicatorView.startAnimating()
        //        }
    }
    
    func hideLoader() {
        
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorView.removeFromSuperview()
            self.loadingLabel.removeFromSuperview()
            self.loadingView.removeFromSuperview()
            self.containerView.removeFromSuperview()
        }
    }
}
extension String{
    func convertDateDDMMMYYYY()->String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatterGet.date(from:self){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM,yyyy"
            return dateFormatter.string(from: date)
        }
        return ""
    }
}
