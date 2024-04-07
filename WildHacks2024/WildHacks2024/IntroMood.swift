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
    var userPersona: String
    
    @State private var selectedMood: String? = nil
    @State private var isNavigationActive = false
    
    
    let backgroundColor = Color(red: 238 / 255, green: 237 / 255, blue: 222 / 255) //beige
    
    let toggleColor = Color(red: 129 / 255, green: 103 / 255, blue: 85 / 255) //darker brown
    
    let accentColor = Color(red: 178 / 255, green: 198 / 255, blue: 249 / 255) //bb blue
    var body: some View {
//        NavigationStack{
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
//                        .padding(.leading, -70)
                        Text("What are you in")
                            .font(.largeTitle)
                            .bold()
                        Text("the mood for?")
                            .font(.largeTitle)
                            .padding(.top, -15)
                            .bold()
                        
                        
                        
                        Image(DeterminePersonaHead(for: userPersona))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width/2, height: geometry.size.height/4)
                            .padding(.bottom, -20)
                            .padding(.top, -20)
                        
                        HStack{
                            Text("You have been in a")
                            Text(userPersona)
                            
                        }
                        Text("mood recently. Wanna try something new?")
                            .padding(.top, -10)
                            .padding(.bottom, 20)
                        
                        let buttonWidth = geometry.size.width * (6.5/8) // Leaves 1/8th margin on each side
                        
                        Group {
                            NavigationLink(destination: MoodRecommendations(SelectedMood: "happy")) {
                                Text("Blast Powerhouse")
                            }
                            .frame(width: buttonWidth, height: 50, alignment: .center)
                            .font(.system(size : 20, weight: .medium))            .background(lighterButtonColor)
                            .foregroundColor(.black)
                            .cornerRadius(30)
                            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
                            .padding(.bottom, 10)

                            
                            NavigationLink(destination: MoodRecommendations(SelectedMood: "sad")) {
                                Text("Soul Searchers")
                            }
                            .frame(width: buttonWidth, height: 50, alignment: .center)
                            .font(.system(size : 20, weight: .medium))            .background(lighterButtonColor)
                            .foregroundColor(.black)
                            .cornerRadius(30)
                            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
                            .padding(.bottom, 10)
                            
                            NavigationLink(destination: MoodRecommendations(SelectedMood: "basic")) {
                                Text("(Not) like other girls")
                            }
                            .frame(width: buttonWidth, height: 50, alignment: .center)
                            .font(.system(size : 20, weight: .medium))            .background(lighterButtonColor)
                            .foregroundColor(.black)
                            .cornerRadius(30)
                            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
                            .padding(.bottom, 10)
                            
                            NavigationLink(destination: MoodRecommendations(SelectedMood: "study")) {
                                Text("Study Bug")
                            }
                            .frame(width: buttonWidth, height: 50, alignment: .center)
                            .font(.system(size : 20, weight: .medium))            .background(lighterButtonColor)
                            .foregroundColor(.black)
                            .cornerRadius(30)
                            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
                            .padding(.bottom, 10)
                            
                            
                            NavigationLink(destination: MoodRecommendations(SelectedMood: "mixed")) {
                                Text("Global Groover")
                            }
                            .frame(width: buttonWidth, height: 50, alignment: .center)
                            .font(.system(size : 20, weight: .medium))            .background(lighterButtonColor)
                            .foregroundColor(.black)
                            .cornerRadius(30)
                            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
                            .padding(.bottom, 10)
                            
                            
                        }//group
                        
                        
                        
                        
                        
                    }//vstack
                    .frame(width:geometry.size.width / 1.2)
                    .padding()
                }//zstack
            }//geometryreader


//        }//Navigation Stack
//        .navigationDestination(for: String.self) { mood in
//            MoodRecommendations(SelectedMood: mood)
//            
//        }
        
        
        }
    func SelectedMoodButton() {
        isNavigationActive = true
    }

}
    

    
//    struct MoodRecommendations: View {
//        let selectedMood: String
//        
//        var body: some View {
//            Text("Recommendations for \(selectedMood)")
//        }
//    }


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
        IntroMood(userPersona: "study")
    }
}
