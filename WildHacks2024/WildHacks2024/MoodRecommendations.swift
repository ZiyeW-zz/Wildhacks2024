//
//  MoodRecommendations.swift
//  WildHacks2024
//
//  Created by Ziye Wang on 4/6/24.
//

import SwiftUI

struct MoodRecommendations: View {
    var SelectedMood: String
    
    let backgroundColor = Color(red: 238 / 255, green: 237 / 255, blue: 222 / 255) //beige
    
    let toggleColor = Color(red: 129 / 255, green: 103 / 255, blue: 85 / 255) //darker brown
    
    let accentColor = Color(red: 178 / 255, green: 198 / 255, blue: 249 / 255) //bb blue
    var body: some View {
        GeometryReader{ geometry in
            ZStack{

                backgroundColor
                    .ignoresSafeArea()
                VStack(spacing: 10){

                    
                    Image("NotLikeOtherGirlsHeadshot")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width/2, height: geometry.size.height/5 )

                    
                    Text(SelectedMood)
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, -10)
                         

                    
                    Group {
                        


                    }

                    
                    
                    
                    
                }//vstack
                .frame(width:geometry.size.width / 1.2)
                .padding()
            }//zstack
        }//geometryreader
       
    }//body
    func SourceMood(){
                 }
}




#Preview {
    
    MoodRecommendations(SelectedMood: "Blast Powerhouse")
}
