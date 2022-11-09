//
//  TableNotizyViewController.swift
//  Notizy
//
//  Created by Mirko Weitkowitz on 09.09.22.
//

import UIKit
import VisionKit
import FirebaseAuth

class TableNotizyVC: UIViewController {
    
    @IBOutlet weak var homeView: UIView!
    
    
    @IBOutlet weak var imageHome: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeView.layer.cornerRadius = 15
        homeView.layer.shadowColor = UIColor.green.cgColor
        homeView.layer.shadowOffset = .zero
        homeView.layer.shadowOpacity = 0.5
        homeView.layer.shadowRadius = 20
       
        
//        HomeImage einstellung
        
        imageHome.layer.cornerRadius = 15
        imageHome.layer.borderWidth = 3
        imageHome.layer.borderColor = UIColor.green.cgColor

    }
    
    
    
    @IBAction func touchUpInsideCameraButton(_ sender: Any) {
        
        configureDocumentView()
    }
    
    private func configureDocumentView(){
        let scanningDocumentVC = VNDocumentCameraViewController()
        scanningDocumentVC.delegate = self
        self.present(scanningDocumentVC, animated: true, completion: nil)
    }
    
    
}

extension TableNotizyVC:VNDocumentCameraViewControllerDelegate{
    
    func documentCameraViewController(_ controller:VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan){
        
        for pageNumber in 0..<scan.pageCount{
            let image = scan.imageOfPage(at:pageNumber)
            print(image)
        }
        
        controller.dismiss(animated: true, completion: nil)
        
    }
    
}

