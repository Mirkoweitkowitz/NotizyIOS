//
//  FirestoreReadMasterTVCTableViewController.swift
//  Notizy
//
//  Created by Mirko Weitkowitz on 08.11.22.
//

import UIKit
import FirebaseFirestore

class FirestoreReadMasterTVC: UITableViewController {
    
    let db = Firestore.firestore()
    var recipes = [Recipe]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Rezepte"

        //TODO: fetchRecipes
        fetchRecipes { newRecipes in
            self.recipes = newRecipes
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func fetchRecipes(completion: @escaping([Recipe]) -> Void) {
        
        db.collection("Rezepte").getDocuments() { querySnapshot, error in
            if let error = error {
                print("Error getting Documents: \(error)")
            } else {
                var recipesToShow = [Recipe]()
                
                for document in querySnapshot!.documents {
                    
                    var recipe = Recipe()
                    let recipeData = document.data()
                    
                    recipe.recipeTitle = recipeData["recipeTitle"] as? String
                    recipe.cook = recipeData["chef"] as? String
                    recipe.ingredients = recipeData["ingredients"] as? [String]
                    
                    recipesToShow.append(recipe)
                }
                completion(recipesToShow)
            }
        }
        
        
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)

        // Configure the cell...
        var content = cell.defaultContentConfiguration()
        content.text = recipes[indexPath.row].recipeTitle
        cell.contentConfiguration = content

        return cell
    }


    //MARK: did Select Row At
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let cell = tableView.cellForRow(at: indexPath)
         self.performSegue(withIdentifier: "showDetails", sender: cell)
     }

    //MARK: Delete
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            db.collection("Rezepte").document(recipes[indexPath.row].recipeTitle!).delete() { err in
                if let err = err {
                    print("Error removing document \(err)")
                } else {
                    print("Document deleted!")
                }
                
            }
            
            recipes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         if segue.identifier == "showDetails" {
             let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
             let dest = segue.destination as! FirestoreReadDetailsVC
             dest.recipe = recipes[indexPath!.row]
         }
     }

}
