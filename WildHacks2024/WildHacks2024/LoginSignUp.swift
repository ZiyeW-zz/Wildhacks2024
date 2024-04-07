//
//  LoginSignUp.swift
//  WildHacks2024
//
//  Created by Ziye Wang on 4/6/24.
//

import SwiftUI

let lightGreen = Color(red: 180 / 255, green: 220 / 255, blue: 160 / 255) //lighterbutton color, for unselected

let darkishGreen = Color(red: 150 / 255, green: 190 / 255, blue: 130 / 255)


struct LoginSignUp: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var isSignUp = false
    
    @EnvironmentObject var authManager: AuthService

    let backgroundColor = Color(red: 238 / 255, green: 237 / 255, blue: 222 / 255) //beige
    
    let toggleColor = Color(red: 129 / 255, green: 103 / 255, blue: 85 / 255) //darker brown
    
    
    let accentColor = Color(red: 178 / 255, green: 198 / 255, blue: 249 / 255) //bb blue
    
    var body: some View {
            ZStack{
                backgroundColor // Use the custom color here
                    .ignoresSafeArea()
                
                VStack{
                    if isSignUp {
                        Text("JOIN US")
                            .font(.largeTitle)
                            .bold()
                            .padding()
                            .foregroundColor(toggleColor)
                            .padding(.top, -110)

                        Text("Sign Up")
                            .font(.title)
                            .fontWeight(.regular)
                            .bold()
                            .padding()
                            .foregroundColor(toggleColor)
                            .padding(.top, -80)

                    }
                    else {
                        Text("WELCOME")
                            .font(.largeTitle)
                            .bold()
                            .padding()
                            .foregroundColor(toggleColor)
                            .padding(.top, -110)
                        Text("Sign In")
                            .font(.title)
                            .fontWeight(.regular)
                            .bold()
                            .padding()
                            .foregroundColor(toggleColor)
                            .padding(.top, -80)
                        
                        Button(action: {}) {
                            HStack {
                                Image("SpotifyLogo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 24) // Adjust size as needed
                                Text("Open in Spotify")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(Color(red: 129/255, green: 189/255, blue: 114/255)) // Spotify color
                            .cornerRadius(8)
                        }

                        
                        Text("---------------------OR---------------------")
                            .padding(.bottom, 10)
                            .foregroundColor(toggleColor)
                            .font(.system(size: 15))

                    }
                    Text("E-mail address").padding(.horizontal, -165)
                        .padding(.bottom, -100)
                        .foregroundColor(toggleColor)
                        .font(.system(size: 15))
                    TextField("", text: $email)
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                        .frame(width:330, height:40)
                        .background(Color.clear)
                        .overlay(RoundedRectangle(cornerRadius: 10) // Adjust corner radius as needed
                            .stroke(toggleColor, lineWidth: 1) // White stroke with a line width of 1
                    )
                        .cornerRadius(10)
                        .padding(.top, 15)
                    
                    Text("Password").padding(.horizontal, -165)
                        .padding(.bottom, -100)
                        .padding(.top, 10)
                        .foregroundColor(toggleColor)
                        .font(.system(size: 15))
                    SecureField("", text: $password)
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                        .frame(width:330, height:40)
                        .background(Color.clear)
                        .overlay(RoundedRectangle(cornerRadius: 10) // Adjust corner radius as needed
                            .stroke(toggleColor, lineWidth: 1) // White stroke with a line width of 1
                    )
                        .cornerRadius(10)
                        .padding(.top, 15)
                    
                    if(isSignUp){
                        
                        Text("Sign Up").frame(width: 330, height: 40, alignment: .center)
                                .background(darkishGreen)
                                                    .foregroundColor(backgroundColor)
                                                    .cornerRadius(10)
                                                    .padding(.top, 20)

                                            }
                                        
                    else {
                        Button("Log In") {
                            authManager.login(username: email, password: password)
                        }
                        .frame(width:330, height:40, alignment: .center)
                        .background(darkishGreen)
                        .foregroundColor(backgroundColor)
                        .cornerRadius(10)
                        .padding(.top, 20)

                    }
 

                    
                    Button(action: {
                        isSignUp.toggle()
                    }) {
                        Text(isSignUp ? "Already have an account? Log In!" : "Don't have an account? Sign Up!")
                            .font(.system(size: 12))
                            .foregroundColor(toggleColor)
                            .padding(.top, 1)
                    }
                }
                .padding()
                .background(Rectangle()
                    .foregroundColor(Color.clear)
                    .cornerRadius(15)
                    .shadow(radius: 5))
                .padding()
            }
            

    }
    
    func signUp(email: String, password: String) {

    }
}


struct SLoginSignUp_Previews: PreviewProvider {
    static var previews: some View {
        LoginSignUp()
    }
}

