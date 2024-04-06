//
//  LoginSignUp.swift
//  WildHacks2024
//
//  Created by Ziye Wang on 4/6/24.
//

import SwiftUI

struct LoginSignUp: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var isSignUp = false
    
    @State private var isActive = false
    
    let backgroundColor = Color(red: 238 / 255, green: 237 / 255, blue: 222 / 255) //beige
    
    let toggleColor = Color(red: 129 / 255, green: 103 / 255, blue: 85 / 255) //darker brown
    
    let accentColor = Color(red: 178 / 255, green: 198 / 255, blue: 249 / 255) //bb blue
    
    var body: some View {
        
        NavigationView {
            ZStack{
                backgroundColor // Use the custom color here
                    .ignoresSafeArea()
                
                VStack{
                    if isSignUp {
                        Text("Sign Up")
                            .font(.largeTitle)
                            .bold()
                            .padding()
                            .foregroundColor(backgroundColor)
                    }
                    else {
                        Text("Login")
                            .font(.largeTitle)
                            .bold()
                            .padding()
                            .foregroundColor(backgroundColor)
                    }
                    Text("Email").padding(.horizontal, -120)
                        .padding(.bottom, -100)
                        .foregroundColor(Color.white)
                        .font(.system(size: 15))
                    TextField("", text: $email)
                        .padding()
                        .frame(width:250, height:50)
                        .overlay(Rectangle().foregroundColor(Color.white).frame(height: 1).padding(.top, 5), alignment: .bottomLeading)
                        .cornerRadius(10)
                        .padding(.bottom, 5)
                    
                    Text("Password").padding(.horizontal, -120)
                        .padding(.bottom, -100)
                        .padding(.top, 10)
                        .foregroundColor(Color.white)
                        .font(.system(size: 15))
                    SecureField("", text: $password)
                        .padding()
                        .frame(width:250, height:50)
                        .overlay(Rectangle().foregroundColor(Color.white).frame(height: 1).padding(.top, 5), alignment: .bottomLeading)
                        .cornerRadius(10)
                        .padding(.bottom, 10)
                    
                    if(isSignUp){
                        NavigationLink(destination: ContentView()) {
                        Text("Sign Up").frame(width: 150, height: 30, alignment: .center)
                                .background(accentColor)
                                                    .foregroundColor(.white)
                                                    .cornerRadius(10)
                                            }
                                        }
                    else {

                        Text("Login").frame(width: 150, height: 30, alignment: .center)
                                                    .background(accentColor)
                                                    .foregroundColor(.white)
                                                    .cornerRadius(10)
                    }
 

                    
                    Button(action: {
                        isSignUp.toggle()
                    }) {
                        Text(isSignUp ? "Already have an account? Login!" : "Don't have an account? Sign Up!")
                            .font(.system(size: 12))
                            .foregroundColor(accentColor)
                            .padding(.bottom, 20)
                    }
                }
                .padding()
                .background(Rectangle()
                    .foregroundColor(toggleColor)
                    .cornerRadius(15)
                    .shadow(radius: 15))
                .padding()
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func signUp(email: String, password: String) {

    }
}


struct SLoginSignUp_Previews: PreviewProvider {
    static var previews: some View {
        LoginSignUp()
    }
}
//#Preview {
//    LoginSignUp()
//}
