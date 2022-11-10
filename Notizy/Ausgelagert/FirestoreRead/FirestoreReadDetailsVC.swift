//
//  FirestoreReadDetailsVC.swift
//  Notizy
//
//  Created by Mirko Weitkowitz on 08.11.22.
//

import UIKit

class FirestoreReadDetailsVC: UIViewController {


    var recipe: Recipe!
    var ingredients: [String]!
    
    @IBOutlet weak var recipeTitleTF: UITextField!
    @IBOutlet weak var chefTF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        recipeTitleTF.text = recipe.recipeTitle
        chefTF.text = recipe.cook
        ingredients = recipe.ingredients
    }
    

}

extension FirestoreReadDetailsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if recipe.ingredients == nil {
            return 0
        } else {
            return recipe.ingredients!.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = recipe.ingredients![indexPath.row]
        cell.contentConfiguration = content
        
        return cell
    }
    
    
    
}

