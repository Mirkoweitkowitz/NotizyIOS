//
//  NotizyCollectionVCViewController.swift
//  Notizy
//
//  Created by Mirko Weitkowitz on 06.10.22.
//

import UIKit
import AVFoundation

protocol CollectionViewCellDelegate: AnyObject {
    func didSelectItem(with model: CollectionTableCellModel)
}
class NotizyCollectionVC: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
//    MARK: collectionView
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("hallo du da")
    }
    
    private var collectionView: UICollectionView?
    
    private let table: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        
        return table
    }()
    
    
    var colors: [UIColor] = [
        .link,
        .systemGreen,
        .darkGray,
        .orange,
        .cyan,
        .black,
        .blue,
        .brown,
        .gray,
        .lightGray,
        .systemPink,
        .purple]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        MARK: - tableHeaderView
                table.tableHeaderView = createTableHeader()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width/3.2,
                                 height: view.frame.size.height/6.5)
        
        layout.sectionInset = UIEdgeInsets(top: 0,
                                           left: 0,
                                           bottom: 0,
                                           right: 0)
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        
        collectionView?.register(UICollectionViewCell.self,forCellWithReuseIdentifier:"cell")
        collectionView?.delegate = self
        collectionView?.dataSource = self
//        backgroundColor einstellen
        collectionView?.backgroundColor = .clear
        view.addSubview(collectionView!)
        
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:)))
        
        collectionView?.addGestureRecognizer(gesture)
        
    }
    
    //    MARK: - Video im Header einbetten
        
        private func createTableHeader() -> UIView? {
            guard let path = Bundle.main.path(forResource: "Skizzen",
                                              ofType: "mp4") else {
                return nil
            }

            let url = URL(fileURLWithPath: path)

            let player = AVPlayer(url: url)
            player.volume = 0

            let headerView = UIView(frame:CGRect(x: 0,
                                                 y: 0,
                                                 width: view.frame.size.width,
                                                 height: view.frame.size.height))

            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = headerView.bounds
            headerView.layer.addSublayer(playerLayer)

            playerLayer.videoGravity = .resizeAspectFill
            player.play()

            return headerView
        }
    
    @objc func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
        guard let collectionView = collectionView else {
            return
        }
        
        switch gesture.state {
        case .began:
            guard let targetIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
                return
            }
            collectionView.beginInteractiveMovementForItem(at: targetIndexPath)
            
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = colors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width/3.2,
                      height: view.frame.size.height/6.5)
    }

//     Re-order
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = colors.remove(at: sourceIndexPath.row)
        colors.insert(item, at: destinationIndexPath.row)
        
    }
    
}
