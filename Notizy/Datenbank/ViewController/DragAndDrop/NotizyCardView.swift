//
//  ViewController.swift
//  Notizy
//
//  Created by Mirko Weitkowitz on 08.09.22.
//

import UIKit


class NotizyCardView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
 
  
    @IBOutlet weak var notizyCV: UICollectionView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        notizyCV.delegate = self
        notizyCV.dataSource = self
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 44
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "notes", for: indexPath) as! NotizyCVC
        cell.notesTXT.text = "Guten Tag Syntax"
        cell.backgroundColor = .green
        
        cell.notizyLBL.text = "Lars"
        cell.backgroundColor = .darkGray
        
        return cell
        
    }

}

