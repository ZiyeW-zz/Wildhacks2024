//
//  IntroMood.swift
//  WildHacks2024
//
//  Created by Ziye Wang on 4/6/24.
//
import SwiftUI

let lighterButtonColor = Color(red: 180 / 255, green: 220 / 255, blue: 160 / 255)
let darkerGreen = Color(red: 150 / 255, green: 190 / 255, blue: 130 / 255)

let moodsList = [
    "happy": "Blast Powerhouse",
    "sad": "Soul Searchers",
    "basic": "(Not) like other girls",
    "study": "Study Bug",
    "mixed": "Global Groover"
]

struct IntroMood: View {
    var userPersona: String
    @State private var recommendations: [String] = []
    @State private var activeDestination: String? = nil
    
    let backgroundColor = Color(red: 238 / 255, green: 237 / 255, blue: 222 / 255)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                backgroundColor.ignoresSafeArea()
                VStack(spacing: 10) {
                    greetingSection
                    Image(DeterminePersonaHead(for: userPersona))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width/2, height: geometry.size.height/4)
                        .padding(.bottom, -20)
                        .padding(.top, -20)
                    moodQuestionSection
                    
                    ForEach(Array(moodsList.keys), id: \.self) { moodKey in
                        Button(action: {
                            Task {
                                await fetchRecommendations(forMood: moodKey)
                            }
                        }) {
                            Text(moodsList[moodKey, default: ""])
                                .frame(width: geometry.size.width * (6.5/8), height: 50, alignment: .center)
                                .font(.system(size: 20, weight: .medium))
                                .background(lighterButtonColor)
                                .foregroundColor(.black)
                                .cornerRadius(30)
                                .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
                                .padding(.bottom, 10)
                        }
                    }
                    ForEach(Array(moodsList.keys), id: \.self) { moodKey in
                         NavigationLink(destination: MoodRecommendations(SelectedMood: moodKey, recommendations: recommendations), isActive: Binding(get: {
                             self.activeDestination == moodKey
                         }, set: { _ in })) {
                             EmptyView()
                         }.hidden()
                     }
                 }
                .frame(width: geometry.size.width / 1.2)
                .padding()
            }
        }
    }
    
    var greetingSection: some View {
        HStack {
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
    }
    
    var personaImageSection: some View {
        GeometryReader { geometry in
                Image(DeterminePersonaHead(for: userPersona))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width/2, height: geometry.size.height/4)
                    .padding(.bottom, -20)
                    .padding(.top, -20)
        }
    }
    
    var moodQuestionSection: some View {
        VStack {
            Text("You have been in a")
            Text(userPersona)
            
            Text("mood recently. Wanna try something new?")
                .padding(.top, -10)
                .padding(.bottom, 20)
        }
    }
    
    func fetchRecommendations(forMood mood: String) async {
        guard let url = URL(string: "http://127.0.0.1:5000/get-recommendations?desiredmood=\(mood)") else {
            print("Invalid URL")
            
            DispatchQueue.main.async {
                self.activeDestination = mood
            }
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let recommendations = try JSONDecoder().decode([String].self, from: data)
//            DispatchQueue.main.async {
//                self.tempPersona = decodedResponse.persona
//                print("Fetched Persona: \(self.tempPersona)")
//            }
            DispatchQueue.main.async {
                self.recommendations = recommendations
                print("Reccomendations for the desiredmood=\(mood), is \(self.recommendations)")
                self.activeDestination = mood
            }
        } catch {
            print("Failed to fetch data: \(error)")
        }
    }
}

// Assume MoodRecommendations is properly defined to accept `selectedMood` and `recommendations`.

struct IntroMood_Previews: PreviewProvider {
    static var previews: some View {
        IntroMood(userPersona: "study")
    }
}
