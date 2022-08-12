//
//  ViewController.swift
//  Download_Images_AlamoFire
//
//  Created by Zhora Babakhanyan on 8/11/22.

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var complatedLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    let imageURL = "https://images.unsplash.com/photo-1597431842922-d9686a23baa6?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=800&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY2MDIyMTUzNg&ixlib=rb-1.2.1&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=1900"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
        getImage(url: imageURL)
    }
    
    
    
    //MARK: - Image Download Service
    func getImage(url: String) {
        AF.download(url)
            .validate()
        
            .downloadProgress {progress in
                self.complatedLabel.text = progress.localizedDescription
                
                self.progressView.setProgress(Float(progress.fractionCompleted), animated: true)
            }
        
            .responseData { (resopnse) in
                if let data = resopnse.value {
                    let imageData = UIImage(data: data)
                    self.imageView.image = imageData
                    self.indicator.stopAnimating()
                }else{
                    self.complatedLabel.text = "Download Error"
                }
                
                self.indicator.isHidden = true
                self.progressView.isHidden = true
                
            }
    }
}

