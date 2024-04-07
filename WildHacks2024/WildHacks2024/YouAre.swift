//
//  YouAre.swift
//  WildHacks2024
//
//  Created by Ziye Wang on 4/6/24.
//

import SwiftUI

struct YouAre: View {
    
    var user : String
    var userPersona: String
    let backgroundColor = Color(red: 243 / 255, green: 229 / 255, blue: 202 / 255) // Beige
    let toggleColor = Color(red: 129 / 255, green: 103 / 255, blue: 85 / 255) // Darker brown
    let accentColor = Color(red: 178 / 255, green: 198 / 255, blue: 249 / 255) // BB blue

    var body: some View {
        ScrollView{
            
            VStack {
                Image(DeterminePersonaHead(for: userPersona))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .background(Circle().foregroundColor(backgroundColor))
                    .frame(width: 250, height: 250) // Adjust the frame as needed
                    .padding(.top, 20)
                
                Text("@meefy101")
                    .foregroundColor(toggleColor)
                    .padding(.bottom, 5)
                
                Text("Currently listening: Lacy")
                    .font(.system(size: 15))
                    .frame(width: 200, height: 5)
                    .foregroundColor(.white)
                    .padding()
                    .background(toggleColor)
                    .cornerRadius(15)
                    .padding(.bottom, 30)
                
                TodayMood(backgroundColor: backgroundColor)
                    .frame(height: 150)
                    .padding()
                
//                MoodStats(toggleColor: toggleColor, userPersona: userPersona)
//                    .frame(height: 100)
//                    .frame(width: 200, height: 100)
//                    .padding()
                
                MoodStats(toggleColor: toggleColor, userPersona: userPersona)
                    .frame(width: 200, height: 100)
                    .padding(.top, 70)
                
                Spacer()
                
            } //Vstack
        }
        

    }//body
    


}

struct TodayMood : View {
    var backgroundColor: Color
    
    var body: some View {
        VStack {
            
                Text("Collected Personas")
                    .padding(.top, 20)
                    .font(.system(size: 15, weight: .bold))
                    .padding(.bottom, -20)


                // Image("YourImageNameHere") // Specify your image name
            ScrollView{
                Image("ListOfHEads")
                    .resizable()
                    .scaledToFit()
//                    .frame(width: 250)
            }
            .padding()
                
        }
        .frame(width: 350, height: 200) // Set the frame for the VStack to match the intended background size
        .background(Rectangle().foregroundColor(backgroundColor)) // Apply the background
        .cornerRadius(15)
        .shadow(radius: 3)
        .padding()
    }
}

struct MoodStats: View {
    var toggleColor: Color
    var userPersona: String // Add this line

    var body: some View {
        NavigationLink(destination: HomepageView(spotifyUser: "meefy101", UserPersona: userPersona)) {
            // Your content
        }
        .frame(width: 350, height: 200)
        .background(Rectangle().foregroundColor(toggleColor))
        .cornerRadius(15)
        .shadow(radius: 3)
    }
}




struct YouAre_Previews: PreviewProvider {
    static var previews: some View {
        YouAre(user: "meefy101", userPersona: "happy")
    }
}
