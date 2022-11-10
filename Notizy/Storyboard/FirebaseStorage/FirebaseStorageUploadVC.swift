//
//  FirebaseStorageUploadVC.swift
//  Notizy
//
//  Created by Mirko Weitkowitz on 08.11.22.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

class FirebaseStorageUploadVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameThisImgTF: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        nameThisImgTF.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }
    @IBAction func uploadImgBtnTapped(_ sender: UIButton) {
        
        // Test, ob ein Bild vorhanden ist
        guard imgView.image != nil else { return }
        
        // Referenz zum Storage
        let storageRef = Storage.storage().reference()
        
        // Bild in Data umwandeln
        guard let imageData = imgView.image?.pngData() else { return }
        
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



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
