//
//  YouAre.swift
//  WildHacks2024
//
//  Created by Ziye Wang on 4/6/24.
//

import SwiftUI

struct YouAre: View {
    let backgroundColor = Color(red: 243 / 255, green: 229 / 255, blue: 202 / 255) //beige
    
    let toggleColor = Color(red: 129 / 255, green: 103 / 255, blue: 85 / 255) //darker brown
    
    let accentColor = Color(red: 178 / 255, green: 198 / 255, blue: 249 / 255) //bb blue
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                VStack (spacing: 10){
                //            backgroundColor.ignoresSafeArea()
                Image("NotLikeOtherGirlsHeadshot").resizable()
                        .aspectRatio(contentMode: .fit)
                        .background(Circle().foregroundColor(backgroundColor))
//                        .frame(width: geometry.size.width/2, height: geometry.size.height/2, alignment: .center)
//                        .position(x:geometry.size.width/2, y:geometry.size.height/8)
                        .padding(.top, 20)
                    
                    Text("@meefy101")
                        .foregroundColor(toggleColor)
                        .padding(.bottom, 5)
                    Text("Lacy")
                        .font(.system(size: 20))
                        .background(Rectangle().foregroundColor(toggleColor).frame(width: geometry.size.width/2, height:geometry.size.height/20).cornerRadius(15))
                        .foregroundColor(.white)
                        .padding(.bottom, 50)
                    
                    
                    TodayMood(backgroundColor: backgroundColor) // Instantiate your TodayMood view here
                        .padding()
                        .frame(width: 200, height: 100)
                    
                    MoodStats(toggleColor: toggleColor) // Instantiate your TodayMood view here
                        .padding()
                        .frame(width: 200, height: 100)



                
                    
                    
                }//vstack
//                .frame(width:geometry.size.width)
                .padding(.leading, 30)
                .padding(.trailing, 30)


                
            }//zstack
        } //geomtetry
    }//body
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
