//
//  YouAre.swift
//  WildHacks2024
//
//  Created by Ziye Wang on 4/6/24.
//

import SwiftUI

struct YouAre: View {
    let backgroundColor = Color(red: 243 / 255, green: 229 / 255, blue: 202 / 255) // Beige
    let toggleColor = Color(red: 129 / 255, green: 103 / 255, blue: 85 / 255) // Darker brown
    let accentColor = Color(red: 178 / 255, green: 198 / 255, blue: 249 / 255) // BB blue

    var body: some View {
        VStack {
            Image("NotLikeOtherGirlsHeadshot")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .background(Circle().foregroundColor(backgroundColor))
                .frame(width: 200, height: 200) // Adjust the frame as needed
                .padding(.top, 20)

            Text("@meefy101")
                .foregroundColor(toggleColor)
                .padding(.bottom, 5)

            Text("Lacy")
                .font(.system(size: 20))
                .foregroundColor(.white)
                .padding()
                .background(toggleColor)
                .cornerRadius(15)
                .padding(.bottom, 50)

            TodayMood(backgroundColor: backgroundColor)
                .frame(width: 200, height: 100)
                .padding()

            MoodStats(toggleColor: toggleColor)
                .frame(width: 200, height: 100)
                .padding()
        }
//        .background(backgroundColor)
//        .cornerRadius(15)
//        .shadow(radius: 3)
//        .padding() // Add some padding around the entire VStack to ensure it's not touching the edges of the screen.
    }
}

struct TodayMood : View {
    var backgroundColor: Color
    
    var body: some View {
        VStack {
            Text("Today's Mood")
                .padding(.top, 20)
            // Image("YourImageNameHere") // Specify your image name
            Circle()
                .foregroundColor(.brown)
                .frame(width: 100, height: 100)
            Text("VibeyBear")
        }
        .frame(width: 300, height: 150) // Set the frame for the VStack to match the intended background size
        .background(Rectangle().foregroundColor(backgroundColor)) // Apply the background
        .cornerRadius(15)
        .shadow(radius: 3)
    }
}

struct MoodStats : View {
    var toggleColor: Color
    
    var body: some View {
        NavigationLink(destination: HomepageView()){
//            Text("Today's Mood")
//                .padding(.top, 20)
//            // Image("YourImageNameHere") // Specify your image name
//            Circle()
//                .foregroundColor(.brown)
//                .frame(width: 100, height: 100)
//            Text("VibeyBear")
        }
        .frame(width: 300, height: 150) // Set the frame for the VStack to match the intended background size
        .background(Rectangle().foregroundColor(toggleColor)) // Apply the background
        .cornerRadius(15)
        .shadow(radius: 3)
    }
}




struct YouAre_Previews: PreviewProvider {
    static var previews: some View {
        YouAre()
    }
}
