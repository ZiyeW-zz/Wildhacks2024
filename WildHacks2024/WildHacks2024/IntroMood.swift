//
//  IntroMood.swift
//  WildHacks2024
//
//  Created by Ziye Wang on 4/6/24.
//

import SwiftUI
let lighterButtonColor = Color(red: 180 / 255, green: 220 / 255, blue: 160 / 255) //lighterbutton color, for unselected

let darkerGreen = Color(red: 150 / 255, green: 190 / 255, blue: 130 / 255)

struct IntroMood: View {
    
    @State private var selectedMood: String? = nil
    @State private var isNavigationActive = false

    
    let backgroundColor = Color(red: 238 / 255, green: 237 / 255, blue: 222 / 255) //beige
    
    let toggleColor = Color(red: 129 / 255, green: 103 / 255, blue: 85 / 255) //darker brown
    
    let accentColor = Color(red: 178 / 255, green: 198 / 255, blue: 249 / 255) //bb blue
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                backgroundColor
                    .ignoresSafeArea()
                VStack(spacing: 10){
                    HStack{
                        Text("Hey")
                            .font(.largeTitle)
                            .bold()
                        Text("Meefy101")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(darkerGreen)
                        Text(".")
                            .font(.largeTitle)
                            .bold()
                            .padding(.leading, -5)
                    }
                    .padding(.leading, -70)
                    Text("What are you in the mood for?")
                        .font(.largeTitle)
                        .bold()
                    
                    
                    
                    Image("NotLikeOtherGirlsHeadshot")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width/2, height: geometry.size.height/6 )
                    
                    
                    Text("You have been melancholy lately. Wanna try something new?")
                        .foregroundColor(.black)
                        .padding(.bottom, 20)
                    
                    let buttonWidth = geometry.size.width * (6.5/8) // Leaves 1/8th margin on each side
                    
                    Group {
                        Button("Blast Powerhouse") {
                            
                            selectedMood = "Blast Powerhouse"
//                            NavigationLink(destination: MoodRecommendations(SelectedMood: selectedMood)){
//                                Text("Help")
                            

                        }
//                        .navigationDestination() {
//                            MoodRecommendations(SelectedMood: selectedMood)
//                        }
//                        .buttonStyle(CustomButtonStyle(buttonWidth: buttonWidth, buttonColor: toggleColor))
//                        .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
//                        
//                        
//                        // Repeat the button with different texts or actions as needed
//                        Button("Soul Searcher") {
//                            selectedMood = "Soul Searcher"
//                        }
//                        .buttonStyle(CustomButtonStyle(buttonWidth: buttonWidth, buttonColor: toggleColor))
//                        .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
//                        
//                        
//                        Button("(Not) like other girls") {
//                            selectedMood = "Blast Powerhouse"
//                        }
//                        .buttonStyle(CustomButtonStyle(buttonWidth: buttonWidth, buttonColor: toggleColor))
//                        .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
//                        
//                        Button("Study Bug") {
//                            selectedMood = "Blast Powerhouse"
//                            //                            Text("Boost Confidence")
//                        }
//                        .buttonStyle(CustomButtonStyle(buttonWidth: buttonWidth, buttonColor: toggleColor))
//                        .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
//                        
//                        
//                        Button("Global Groover") {
//                            selectedMood = "Blast Powerhouse"
//                            //                            Text("Boost Confidence")
//                        }
//                        .buttonStyle(CustomButtonStyle(buttonWidth: buttonWidth, buttonColor: toggleColor))
//                        .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
//                        
                        
                        
                    }
                    //                    if let selectedMood = selectedMood {
                    //                        NavigationLink("", destination: MoodRecommendations(SelectedMood: selectedMood))
                    //                    }
                    
                    
                    
                    
                    
                }//vstack
                .frame(width:geometry.size.width / 1.2)
                .padding()
            }//zstack
        }//geometryreader

        
        
    }//body

}

    
struct CustomButtonStyle: ButtonStyle {
    let buttonWidth: CGFloat
    let buttonColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: buttonWidth, height: 50, alignment: .center)
            .font(.system(size : 20, weight: .medium))            .background(lighterButtonColor)
            .foregroundColor(.black)
            .cornerRadius(30)
            .padding(.bottom, 10)
            .padding(.top, configuration.isPressed ? 5 : 0) // Optional: Change padding on press for a click effect
    }
}
    

struct IntroMood_Previews: PreviewProvider {
    static var previews: some View {
        IntroMood()
    }
}
