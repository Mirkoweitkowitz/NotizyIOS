//
//  DedailNotizyVC.swift
//  Notizy
//
//  Created by Mirko Weitkowitz on 04.10.22.
//

import UIKit

class DedailNotizyVC: UIViewController {
    
    private let myView: UIView = { let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        view.backgroundColor = .link
        view.isUserInteractionEnabled = true
        return view
        
    }()
    
    private let myViewOne: UIView = { let view = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
        view.backgroundColor = .cyan
        view.isUserInteractionEnabled = true
        return view
        
    }()
    private let myViewTwo: UIView = { let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        view.backgroundColor = .orange
        view.isUserInteractionEnabled = true
        return view
        
    }()
    
    private let myViewThree: UIView = { let view = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        view.backgroundColor = .darkGray
        view.isUserInteractionEnabled = true
        return view
        
    }()
    
    
    private var isDragging = false
    private var isDraggingOne = false
    private var isDraggingTwo = false
    private var isDraggingThree = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(myView)
        view.addSubview(myViewOne)
        view.addSubview(myViewTwo)
        view.addSubview(myViewThree)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myView.center = view.center
        myViewOne.center = view.center
        myViewTwo.center = view.center
        myViewThree.center = view.center
        
    }
    
    var oldX: CGFloat = 0
    var oldY: CGFloat = 0
    
    var oldXX: CGFloat = 0
    var oldYY: CGFloat = 0
    
    var oldXXX: CGFloat = 0
    var oldYYY: CGFloat = 0
    
    var oldXXXX: CGFloat = 0
    var oldYYYY: CGFloat = 0
    
}

//MARK: - Touches
// MARK: Extension immer DedailNotizyVC benutzen

extension DedailNotizyVC {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: myView)
        
        
        oldX = location.x
        oldY = location.y
        
        
        if myView.bounds.contains(location){
            isDragging = true
            print("did touch in blue view")
        }
        
        
        let locationone = touch.location(in: myViewOne)
        
        
        if myViewOne.bounds.contains(locationone){
            isDraggingOne = true
            print("did touch in cyan view")
            
            oldXX = locationone.x
            oldYY = locationone.y
        }
        
        let locationtwo = touch.location(in: myViewTwo)
        
        
        if myViewTwo.bounds.contains(locationtwo){
            isDraggingTwo = true
            print("did touch in orange view")
            
            oldXXX = locationtwo.x
            oldYYY = locationtwo.y
        }
        
        let locationthree = touch.location(in: myViewThree)
        
        
        if myViewThree.bounds.contains(locationthree){
            isDraggingThree = true
            print("did touch in darkGray view")
            
            oldXXXX = locationthree.x
            oldYYYY = locationthree.y
        }
    }
        
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            
            
            if isDragging{
                guard let touch = touches.first else {
                    return
                }
                let location = touch.location(in: view)
                
                myView.frame.origin.x = location.x - (myView.frame.size.width/2)
                myView.frame.origin.y = location.y - (myView.frame.size.height/2)
                
            }
            
            if isDraggingOne{
                
                guard let touch = touches.first else {
                    return
                }
                
                let locationone = touch.location(in: view)
                
                
                myViewOne.frame.origin.x = locationone.x - (myViewOne.frame.size.width/2)
                myViewOne.frame.origin.y = locationone.y - (myViewOne.frame.size.height/2)
            }
            
            if isDraggingTwo{
                
                guard let touch = touches.first else {
                    return
                }
                
                let locationtwo = touch.location(in: view)
                
                
                myViewTwo.frame.origin.x = locationtwo.x - (myViewTwo.frame.size.width/2)
                myViewTwo.frame.origin.y = locationtwo.y - (myViewTwo.frame.size.height/2)
                
            }
            
            if isDraggingThree{
                
                guard let touch = touches.first else {
                    return
                }
                
                let locationthree = touch.location(in: view)
                
                
                myViewThree.frame.origin.x = locationthree.x - (myViewThree.frame.size.width/2)
                myViewThree.frame.origin.y = locationthree.y - (myViewThree.frame.size.height/2)
                
            }
        }
    
        
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isDragging = false
        isDraggingOne = false
        isDraggingTwo = false
        isDraggingThree = false
    }
}



