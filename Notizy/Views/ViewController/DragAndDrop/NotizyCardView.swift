//
//  ViewController.swift
//  Notizy
//
//  Created by Mirko Weitkowitz on 08.09.22.
//

import UIKit
import VisionKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore


class NotizyCardView: UIViewController {
 
  
    
    
    @IBOutlet weak var ScanView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        
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

extension NotizyCardView:VNDocumentCameraViewControllerDelegate{
    
    func documentCameraViewController(_ controller:VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan){
        
        for pageNumber in 0..<scan.pageCount{
            DispatchQueue.main.async {
                self.ScanView.image = scan.imageOfPage(at:pageNumber)
                print(self.ScanView.image)
            }
            
            
            
            
            // Referenz zum Storage
            let storageRef = Storage.storage().reference()
            
            // Bild in Data umwandeln
            guard let imageData = ScanView.image?.pngData() else { return }
            
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

