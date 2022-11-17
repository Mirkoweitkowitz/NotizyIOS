//
//  CollectionViewTaskVC.swift
//  Notizy
//
//  Created by Mirko Weitkowitz on 09.09.22.
//

import UIKit
import SwiftUI
import CoreData

// MARK: Swift mit SwiftUI kombiniert
class CollectionViewTaskVC: UIHostingController <FlipCardView> {
    
    required init?(coder:NSCoder) {
        super.init(coder: coder, rootView: FlipCardView())
    }
    
}



struct FlipEffect: GeometryEffect {
    var animatableData: Double {
        get{ angle }
        set { angle = newValue }
    }
    @Binding var flipped:Bool
    var angle:Double
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        DispatchQueue.main.async {
            flipped = angle >= 90 && angle < 270
        }
        let newAngle = flipped ? -180 + angle : angle
        
        let angleInRadians = CGFloat(Angle(degrees: newAngle).radians)
        
        var transform3d = CATransform3DIdentity
        transform3d.m34 = -1/max(size.width, size.height)
        transform3d = CATransform3DRotate(transform3d, angleInRadians, 0, 1, 0)
        transform3d = CATransform3DTranslate(transform3d, -size.width / 2, -size.height / 2, 0)
        
        let affineTransform = ProjectionTransform(CGAffineTransform(translationX: size.width / 2, y: size.height / 2))
        
        return ProjectionTransform(transform3d).concatenating(affineTransform)
    }
    
    
}
// Layout der Karte
struct Card:View {
    var name:String = ""
    var adresse:String = ""
    var email: String = ""
    var notes: String = ""
    var image: String = ""
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 10)
            .fill(LinearGradient(gradient: Gradient(colors: [Color.green, Color.pink]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .frame(width:330, height: 200)
        
        
            .shadow(color: Color("shadow"),radius: 10, x: 5, y: 5)
            .overlay(VStack (alignment:image != "" ? .center : .leading, spacing: 10) {
                if image != "" {
                    Image(image)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .cornerRadius(20)
                        .shadow(color: .black, radius:  20)
                    
                }
                Text(name)
                    .font(.title2)
                    .foregroundColor(.white)
                if adresse != "" {
                    Text(adresse)
                        .font(.body)
                        .foregroundColor(.white)
                }
                if email != "" {
                    Text(email)
                        .font(.body)
                    .foregroundColor(.white)          }
                if notes != ""{
                    Text(notes)
                        .font(.body)
                    .foregroundColor(.white)}
            }
            )
    }
    
}
// Visitenkarten inhalt
struct BusinessCard: View {
    @State var flipped: Bool = false
    @State var flip: Bool = false
    @State var adresse: String?
    @State var name: String?
    @State var email: String?
    @State var notes: String?
    @State var image: String?
    
    var body: some View {
        
        ZStack {
            Card(adresse: adresse ?? "", email: email ?? "",
                 notes: notes ?? "")
            .opacity(flipped ? 0 : 1)
            Card(name: name ?? "", image: image ?? "")
                .opacity(flipped ? 1 : 0)
            
        }
        .modifier(FlipEffect(flipped: $flipped, angle: flip ? 0 : 180))
        .onTapGesture(count: 1, perform: {
            withAnimation {
                flip.toggle()
            }
        })
        
    }
    
}
var mirko = BusinessCard(flipped: false, flip: false, adresse: "Forster Straße 13 / 12627 Berlin", name: "Mirko Weitkowitz", email: "mweitkowitz@web.de", notes: "Notizen", image: "kingMirko")

// Referenz zum Core Data Persistent Store / managedObjectContext
let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

// neuen Benutzer erstellen

//func newUser() -> BusinessCard{
//    @State var adress: String?
//    @State var name: String?
//    @State var email: String?
//    @State var notes: String?
//    @State var image: String?
//
//    @State var mycontact: Contact?
//
//
//
//    var contacts = BusinessCard(flipped: false, flip: false, adresse: adress ?? "", name: name ?? "", email: email ?? "", notes:  notes ?? "", image: image ?? "")
//
//    return contacts
//
//}




struct ContentView: View {
    @State var flipped: Bool = false
    @State var flip: Bool = false
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors:
                    [NSSortDescriptor(keyPath: \Contact.name, ascending: true)])
    var contacts: FetchedResults<Contact>
    
    
    
    var body: some View {
        
        ZStack {
            // MARK: - Scrollbare VisitenKarte
            
            List {
                
                ForEach(contacts) {contact in
                    Section {
                        BusinessCard(flipped: false, flip: false, adresse: contact.adress,
                                     name: contact.name, email: contact.email, notes:  contact.notes, image: contact.image?.description)
                    }
                }
            }.scrollContentBackground(.hidden)
            
            
        }.background(Image("notizy.img")
            .resizable()
            .aspectRatio(UIImage(named: "notizy.img")!.size, contentMode: .fill)
            .clipped())
        .edgesIgnoringSafeArea(.all)
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FlipCardView: View {
    
    var body: some View {
        
        
        ContentView()
            .environment(\.managedObjectContext, context)
        
    }
    
}
