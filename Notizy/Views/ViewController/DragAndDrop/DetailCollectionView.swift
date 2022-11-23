//
//  DetailCollectionView.swift
//  Notizy
//
//  Created by Mirko Weitkowitz on 21.11.22.
//

import UIKit

class DetailCollectionView: UIViewController {

    var currentNotiz: Notiz!
    
    @IBOutlet weak var notesDetail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        notesDetail.text = currentNotiz.title
        notesDetail.sizeToFit()
    }

    
    
}
