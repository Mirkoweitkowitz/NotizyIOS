//
//  FireStoreCreatVC.swift
//  Notizy
//
//  Created by Mirko Weitkowitz on 21.10.22.
//

import UIKit
import FirebaseFirestore

class FireStoreCreatVC: UIViewController {
    
    @IBOutlet weak var recipeTF: UITextField!
    @IBOutlet weak var cookTF: UITextField!
    @IBOutlet weak var ingredientTF: UITextField!
    @IBOutlet weak var ingredientUnitTF: UITextField!
    @IBOutlet weak var ingredientTableView: UITableView!
    
    
    var ingredients = [Ingredient]()
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        ingredientTableView.dataSource = self
    }
    
    @IBAction func addRecipeBtnTapped(_ sender: UIButton) {
        
        db.collection("Rezepte").document(recipeTF.text!).setData([
            "rezeptTitle": recipeTF.text!,
            "chef": cookTF.text!
            
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        //        Tableview befüllen
        if ingredients.isEmpty{
            var ingredientsToSave = [String]()
            for ingredient in ingredients {
                let ingredientName = ingredient.ingredientName!
                let unit = ingredient.ingredientUnit!
                let stringToAppend = "\(ingredientName)  \(unit)"
                ingredientsToSave.append(stringToAppend)
            }
            let ingredientData: [String:Any] = [
                "ingredients": ingredientsToSave]
            
            db.collection("Rezepte").document(recipeTF.text!).setData(ingredientData, merge:true) {err in if err != nil {
                print("error")
                
            }else {
                print("success!")
            }
                
            }
            
        }
        ingredients.removeAll()
        ingredientTableView.reloadData()
        
        recipeTF.text = ""
        cookTF.text = ""
        
    }
    
    @IBAction func addIngredientBTNTapped(_ sender: UIButton) {
        var ingredient = Ingredient()
        ingredient.ingredientName = ingredientTF.text
        ingredient.ingredientUnit = ingredientUnitTF.text
        ingredients.append(ingredient)
        ingredientTableView.reloadData()
        print(ingredients)
        
        ingredientTF.text = ""
        ingredientUnitTF.text = ""
        
    }
    
}

extension FireStoreCreatVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ingredientTableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = ingredients[indexPath.row].ingredientName
        content.secondaryText = ingredients[indexPath.row].ingredientUnit
        cell.contentConfiguration = content
        
        return cell
    }
    
    
}
