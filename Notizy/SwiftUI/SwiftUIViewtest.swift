//
//  SwiftUIViewtest.swift
//  Notizy
//
//  Created by Mirko Weitkowitz on 04.11.22.
//

import SwiftUI
//import UIKit



struct SwiftUIViewtest: View {
   
    
    var body: some View {
        
        VStack {
                 Spacer();
                 Text("Hallo");
                 Text("Hallo2");
                 Text("Hallo2");
                 Text("Hallo2");
                 Text("Hallo2");
                 Text("Hallo2");
                 Text("Hallo2");
                 Spacer();
                 }.background(Image("notizy.img")
                     .resizable()
                     .aspectRatio(UIImage(named: "notizy.img")!.size, contentMode: .fill)
                     .clipped())
                 .edgesIgnoringSafeArea(.all)
         }
     }
        
       
          
   



struct SwiftUIViewtest_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewtest()
    }
}
