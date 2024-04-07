//
//  HomepageView.swift
//  WildHacks2024
//
//  Created by Ziye Wang on 4/6/24.
//

import SwiftUI

struct HomepageView: View {
//    var authService: AuthService
    
    var spotifyUser: String
    var UserPersona: String

    
    let backgroundColor = Color(red: 238 / 255, green: 237 / 255, blue: 222 / 255) //beige
    
    let toggleColor = Color(red: 129 / 255, green: 103 / 255, blue: 85 / 255) //darker brown
    
    let accentColor = Color(red: 178 / 255, green: 198 / 255, blue: 249 / 255) //bb blue
    
    @State private var isAnimating = false
    @State private var isShowingDestinationView = false


    var body: some View {
        NavigationView {
            GeometryReader{ geometry in
                ZStack{
                    //                let pageWidth = geometry.size.width * (7/8) // Leaves 1/8th margin on each side
//                    backgroundColor
//                        .ignoresSafeArea()
                    Image("HomepageBackground")
                        .resizable() // Make the image resizable
                        .aspectRatio(contentMode: .fill) // Fill the aspect ratio
                        .edgesIgnoringSafeArea(.all) // Ignore the safe area to fill the whole screen

//                        .ignoresSafeArea()
                    
                    
                    VStack(spacing: 10){
                        
                        Button(action: OpenFriends) {
                           
                        }
                        .background(
                            Image("Friends")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .padding(.top, -200)
                                .padding(.leading, -150))
                        
                        Image(DeterminePersona(for: UserPersona))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        //                        .frame(width: geometry.size.width, height: geometry.size.height / 2 ) // Adjust the width as needed
                            .shadow(color: Color.black.opacity(0.3), radius: 7, x: 0, y: 5)
                            .offset(y: self.isAnimating ? -10 : 10)
                            .padding(.top, -100)
                        
                        Text("Your Persona")
                            .foregroundColor(toggleColor)
                            .font(.system(size: 30, weight: .medium))
                            .bold()
//                            .padding(.top, 30)
                        Text(DeterminePersonaTitle(for: UserPersona))
                            .padding()
                            .foregroundColor(.white)
                            .background(Rectangle()
                                .foregroundColor(toggleColor).cornerRadius(20))
                            .font(.system(size: 30, weight: .medium))
                            .bold()
                            .padding(.bottom, 30)
                        HStack{
                            // Corrected usage of NavigationLink on line 78 and similar
                            NavigationLink(destination: YouAre(user: spotifyUser, userPersona: UserPersona)) {
                                HStack {
                                    LeftArrowShape()
                                        .frame(width: 50, height: 30)
                                        .foregroundColor(toggleColor)
                                    Text("Profile")
                                }
                            }
                            .padding(.trailing, 50)

                            
                            
                            NavigationLink(destination: IntroMood(userPersona: UserPersona)){
                                Text("Discover Moods")
                                    .frame(width: 70)
                                RightArrowShape()
                                    .frame(width: 50, height: 30)
                                    .foregroundColor(toggleColor)
                                    .cornerRadius(10)
                                
                            }
                            .padding(.leading, 70)
                        }
//                        .padding(.bottom, 30)

                        
                    }//vstack
                    NavigationLink(destination: IntroMood(userPersona: UserPersona), isActive: $isShowingDestinationView) {
                        EmptyView()
                    }//navigationlink
                    
                
                                            
                    
                }//zstack
                .background(NavigationLink("", destination: IntroMood(userPersona: UserPersona)).hidden())
                
            }//geometryreader
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 1).repeatForever()) {
                    self.isAnimating.toggle()
                }
            }
        }//navigation
       
    }//body
    func SourceMood(){
                 }
}

struct Arrow: View {
    var toggleColor: Color
    var body: some View{
        Rectangle()
            .frame(width: 30, height: 5)
            .cornerRadius(10)
            .foregroundColor(toggleColor)
    }
}

struct RightArrowShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Start at the top left
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        // Line to the bottom left
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        // Line to the middle right
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        // Close the path back to the top left
        path.closeSubpath()
        
        return path
    }
}

struct LeftArrowShape: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            // Start at the top right
            path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
            // Line to the bottom right
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            // Line to the middle left
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
            // Close the path back to the top right
            path.closeSubpath()
            
            return path
        }
}

func OpenFriends() {
    
}

    

    
struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView( spotifyUser: "meefy101", UserPersona: "basic")
    }
}
