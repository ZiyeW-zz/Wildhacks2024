//
//  DeterminePersona.swift
//  WildHacks2024
//
//  Created by Ziye Wang on 4/7/24.
//

import SwiftUI

func DeterminePersona(for persona: String) -> String {
    switch persona{
    case "happy":
        return "Blastpower"
    case "sad":
        return "soulsearch"
    case "basic":
        return "Othergirls"
    case "study":
        return "Studybug"
    case "mixed":
        return "globalgroover"
    default:
        return "defaultImage" // Consider having a default image
    }
}



func DeterminePersonaHead(for persona: String)-> String{
    switch persona {
    case "happy":
        return "blasthead"
    case "sad":
        return "soulhead"
    case "basic":
        return "pophead"
    case "study":
        return "bughed"
    case "mixed":
        return "globalhead"
    default:
        return "defaultHeadImage" // Consider having a default image
    }
}

func DeterminePersonaTitle(for persona: String)-> String{
    switch persona {
    case "happy":
        return "Blast Powerhouse"
    case "sad":
        return "Soul Searcher"
    case "basic":
        return "(Not) like other girls"
    case "study":
        return "Study Bug"
    case "mixed":
        return "Global Groover"
    default:
        return "defaultHeadImage" // Consider having a default image
    }
}


// api personas: {'happy': 0, 'sad': 0, 'basic': 0, 'study': 0, 'mixed': 0}
