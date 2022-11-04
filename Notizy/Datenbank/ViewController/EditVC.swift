//
//  EditViewController.swift
//  Notizy
//
//  Created by Mirko Weitkowitz on 09.09.22.
//

import UIKit



class EditVC: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    //MARK: Variablen zur Annahme der Daten
    var contact: Contact!
    var contactIndex: Int!
    
    // Referenz zum Core Data Persistent Store / managedObjectContext
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    weak var delegate: ContactDelegate?
    
    
    @IBOutlet weak var imgContact: UIImageView!
    
    @IBOutlet weak var btnCamera: UIButton!
    
    @IBOutlet weak var nameTXT: UITextField!
    
    @IBOutlet weak var nameLBL: UILabel!
    
    @IBOutlet weak var adressTXT: UITextField!
    
    @IBOutlet weak var adressLBL: UILabel!
    
    @IBOutlet weak var emaiTXT: UITextField!
    
    @IBOutlet weak var emailLBL: UILabel!
    
    @IBOutlet weak var notizTXTView: UITextView!
    
    @IBOutlet weak var motizenLBL: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func dismissDetailView(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    //MARK: Edit-Button Tapped
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        
        if nameTXT.isHidden {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(editButtonTapped(_:)))
            nameLBL.isHidden = true
           
            emailLBL.isHidden = true
            
            nameTXT.isHidden = false
            emaiTXT.isHidden = false
            notizTXTView.isEditable = true
            
            nameTXT.text = nameLBL.text
            emaiTXT.text = emailLBL.text
            
            saveButton.isHidden = false
        
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped(_:)))
            nameLBL.isHidden = false
            emailLBL.isHidden = false
            
            nameTXT.isHidden = true
            emaiTXT.isHidden = true
            notizTXTView.isEditable = false
            notizTXTView.text = contact.notes
            
            saveButton.isHidden = true
        }
    }
    
    
    
 
    
    //MARK: Button: ContactModel speichern
    @IBAction func speichernBTN(_ sender: UIButton) {
        
        contact.name = nameTXT.text
        contact.email = emaiTXT.text
        contact.notes = notizTXTView.text
        
        delegate?.update(contact: contact, index: contactIndex)
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped(_:)))
        
        nameLBL.text = contact.name
        emailLBL.text = contact.email
        notizTXTView.text = contact.notes
        
        nameLBL.isHidden = false
        emailLBL.isHidden = false
        nameTXT.isHidden = true
        emaiTXT.isHidden = true
        notizTXTView.isEditable = false
        saveButton.isHidden = true
        
        // Save Data
        do {
            try self.context.save()
        } catch {
            print("Error")
        }
      
        
    }
    
    //MARK: Toolbar und DatePicker
    func createToolbar() -> UIToolbar {
        // Toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Done Button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        return toolbar
    }
    @objc func donePressed() {
        
        if notizTXTView.isFocused {
            notizTXTView.endEditing(true)
        } else {
            
            self.view.endEditing(true)
        }
    }


    
    @IBAction func cameraBTN(_ sender: UIButton) {
    }

//Keyboard verschwinden lassen
func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.endEditing(true)
    return false
}


override func viewDidLoad() {
    super.viewDidLoad()
    
    // Daten des aktuellen ContactModels anzeigen lassen
    nameLBL.text = contact.name
    emailLBL.text = contact.email
    notizTXTView.text = contact.notes
    
    if contact.image != nil{
        imgContact.image = UIImage(data: contact.image!)
    }
    
   
    
    // Text View verschönern
    notizTXTView.layer.cornerRadius = 3
    notizTXTView.layer.borderWidth = 1
    notizTXTView.layer.borderColor = UIColor.lightGray.cgColor
    
    // Delegates
    nameTXT.delegate = self
    emaiTXT.delegate = self
    notizTXTView.delegate = self
    
    notizTXTView.inputAccessoryView = createToolbar()
  
    
    // Keyboard sichtbar: View verschieben
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    
    }

// objc functions: View verschieben bei aktivem Keyboard
@objc func keyboardWillShow(notification: NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
        if self.view.frame.origin.y == 0 && (notizTXTView.isFirstResponder || emailLBL.isFirstResponder) {
            self.view.frame.origin.y -= keyboardSize.height
        }
    }
}

@objc func keyboardWillHide(notification: NSNotification) {
    if self.view.frame.origin.y != 0 {
        self.view.frame.origin.y = 0
      }
  }

}



