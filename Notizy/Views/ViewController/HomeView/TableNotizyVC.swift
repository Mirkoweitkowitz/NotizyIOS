//
//  TableNotizyViewController.swift
//  Notizy
//
//  Created by Mirko Weitkowitz on 09.09.22.
//

import UIKit
import VisionKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class TableNotizyVC: UIViewController {
    
    @IBOutlet weak var homeView: UIView!
    
    
    @IBOutlet weak var imageHome: UIImageView!
    
    
    @IBOutlet weak var notes: UIButton!
    
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

       
        notes.layer.shadowColor = UIColor.green.cgColor
        notes.layer.shadowOffset = .zero
        notes.layer.shadowOpacity = 0.5
        notes.layer.shadowRadius = 20
        notes.imageView?.layer.cornerRadius = 30
       
        
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
            
            
            
            // Referenz zum Storage
            let storageRef = Storage.storage().reference()
            
            // Bild in Data umwandeln
            guard let imageData = image.pngData() else { return }
            
            //guard let imageDataJpeg = imgView.image?.jpegData(compressionQuality: 1.0) else { return }
            
            // File Path festlegen
            //let path = "images/\(nameThisImgTF.text!).png"
            let path = "images/\(UUID().uuidString).png"
            let fileRef = storageRef.child(path)
            
            // Daten hochladen
            let uploadTask = fileRef.putData(imageData) { metadata, error in
                            if error == nil {
                                print("test dragon")

                    let db = Firestore.firestore()
                    db.collection("images").document().setData([
                        "url": path
                    
                    ])
                            }else {
                                print(error)
                            }
                
            }
        }
        
        controller.dismiss(animated: true, completion: nil)
        
    }
    
}

