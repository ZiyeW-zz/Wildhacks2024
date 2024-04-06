//
//  HomepageView.swift
//  WildHacks2024
//
//  Created by Ziye Wang on 4/6/24.
//

import SwiftUI

struct HomepageView: View {
    let backgroundColor = Color(red: 238 / 255, green: 237 / 255, blue: 222 / 255) //beige
    
    let toggleColor = Color(red: 129 / 255, green: 103 / 255, blue: 85 / 255) //darker brown
    
    let accentColor = Color(red: 178 / 255, green: 198 / 255, blue: 249 / 255) //bb blue
    
    @State private var isAnimating = false

    var body: some View {
        GeometryReader{ geometry in
            ZStack{
//                let pageWidth = geometry.size.width * (7/8) // Leaves 1/8th margin on each side
                backgroundColor
                    .ignoresSafeArea()
                VStack(spacing: 10){
                    Image("NotLikeOherGirls")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
//                        .frame(width: geometry.size.width, height: geometry.size.height / 2 ) // Adjust the width as needed
                        .shadow(color: Color.black.opacity(0.3), radius: 7, x: 0, y: 5)
                        .padding()
                        .offset(y: self.isAnimating ? -10 : 10)

                    Text("March Persona")
                        .foregroundColor(toggleColor)
                        .font(.system(size: 30, weight: .medium))
                        .bold()
                        .padding(.top, 30)
                    Text("(Not?) Like Other Girls")
                        .padding()
                        .foregroundColor(.white)
                        .background(Rectangle()
                            .foregroundColor(toggleColor).cornerRadius(20))
                        .font(.system(size: 30, weight: .medium))
                        .bold()
                    
                }//vstack

            }//zstack
        }//geometryreader
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 1).repeatForever()) {
                self.isAnimating.toggle()
            }
        }
       
    }//body
    func SourceMood(){
                 }
}
    

    
struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
    }
}
//#Preview {
//    HomepageView()
//}
