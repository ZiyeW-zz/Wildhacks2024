//
//  MoodRecommendations.swift
//  WildHacks2024
//
//  Created by Ziye Wang on 4/6/24.
//

import SwiftUI

struct MoodRecommendations: View {
    var SelectedMood: String
    let recommendations: [String]
    
    
    let backgroundColor = Color(red: 238 / 255, green: 237 / 255, blue: 222 / 255) //beige
    
    let toggleColor = Color(red: 129 / 255, green: 103 / 255, blue: 85 / 255) //darker brown
    
    let accentColor = Color(red: 178 / 255, green: 198 / 255, blue: 249 / 255) //bb blue
    var body: some View {
        
        GeometryReader{ geometry in
            
            ZStack{
                
                backgroundColor
                    .ignoresSafeArea()
                ScrollView{
                    VStack(spacing: 10){
                        
                        
                        Image(DeterminePersonaHead(for: SelectedMood))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width / 2, height: geometry.size.height/3 )
                            .padding(.top, -50)
                            .padding(.bottom, -50)
                        
                        
                        Text(DeterminePersonaTitle(for: SelectedMood))
                            .font(.largeTitle)
                            .bold()
                            .padding(.top, -20)
                            .foregroundColor(toggleColor)
                        Text("Personalized Mix based on You.")
                            .font(.system(size: 15))
                            .bold()
                            .padding(.top, -10)
                            .foregroundColor(toggleColor)
                        //                            .frame(.alginment: left)
                        VStack (spacing: 15){
                            ForEach(recommendations, id: \.self) { recommendation in
                                Text(recommendation)
                                //                                .padding()
                                    .foregroundColor(toggleColor)
                                    .font(.system(size: 20, weight: .medium))
                                    .bold()
                                //
                                
                                    .padding(.top, 20)
                                    .padding(.bottom, 10)
                            }

                            
                            
                            
                            
                            
                            
                            
                            
                        }//vstack
                        .frame(width:geometry.size.width / 1.2)
                        .padding()
                    }//zstack
                }//geometryreader
            }//scrollView
            
        }//body
        
    
    }
    func SourceMood(){
    }
}




#Preview {
    

    MoodRecommendations(SelectedMood: "happy", recommendations: ["Work", "song2", "song3"])
}
