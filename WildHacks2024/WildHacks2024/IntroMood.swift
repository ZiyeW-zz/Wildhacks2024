//
//  IntroMood.swift
//  WildHacks2024
//
//  Created by Ziye Wang on 4/6/24.
//

import SwiftUI

struct IntroMood: View {
    let backgroundColor = Color(red: 238 / 255, green: 237 / 255, blue: 222 / 255) //beige
    
    let toggleColor = Color(red: 129 / 255, green: 103 / 255, blue: 85 / 255) //darker brown
    
    let accentColor = Color(red: 178 / 255, green: 198 / 255, blue: 249 / 255) //bb blue
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                let pageWidth = geometry.size.width * (7/8) // Leaves 1/8th margin on each side
                backgroundColor
                    .ignoresSafeArea()
                VStack(spacing: 10){
                    Text("Welcome Back, ")
                        .font(.largeTitle)
                        .bold()
                    
                    Text("Meefy101")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(accentColor)
                        .padding(.top, -10)
                    Text("You have been melancholy lately. What mood would you like to be in today?")
                        .foregroundColor(toggleColor)
                        .padding(.bottom, 20)
                         
                    let buttonWidth = geometry.size.width * (6.5/8) // Leaves 1/8th margin on each side
                    
                    Group {
                        Button(action: BoostConfidence) {
                            Text("Boost Confidence")
                        }
                        .buttonStyle(CustomButtonStyle(buttonWidth: buttonWidth, buttonColor: toggleColor))
                        
                        // Repeat the button with different texts or actions as needed
                        Button(action: BoostConfidence) {
                            Text("Boost Confidence")
                        }
                        .buttonStyle(CustomButtonStyle(buttonWidth: buttonWidth, buttonColor: toggleColor))

                    }

                    
                    
                    
                    
                }//vstack
                .frame(width:geometry.size.width / 1.2)
                .padding()
            }//zstack
        }//geometryreader
       
    }//body
    func BoostConfidence(){
                 }
}
    
struct CustomButtonStyle: ButtonStyle {
    let buttonWidth: CGFloat
    let buttonColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: buttonWidth, height: 40, alignment: .center)
            .foregroundColor(.white)
            .background(buttonColor)
            .cornerRadius(10)
            .padding(.top, configuration.isPressed ? 5 : 0) // Optional: Change padding on press for a click effect
    }
}
    

struct IntroMood_Previews: PreviewProvider {
    static var previews: some View {
        IntroMood()
    }
}
