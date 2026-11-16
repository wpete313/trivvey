//
//  ContentView.swift
//  trivvey
//
//  Created by Will Peterson on 10/30/26.
//

import SwiftUI

struct ContentView: View {
        // store questions
    @State private var questions: [Question] = []
    @State private var allQuestions: [Question] = []
    
    var body: some View {
        NavigationStack {
            List(questions) {question in
                // Add NavigationLink to QuestionView for each question
                NavigationLink(question.prompt) {
                    QuestionView(question: question)
                }
            }
            .navigationTitle("Trivvey")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        questions = Array(allQuestions.shuffled().prefix(10))
                    } label: {
                        Image(systemName: "shuffle")
                    }
                }
            }
            // Add navigationTitle
            // Add shuffle button in toolbar
        }
        .onAppear {
            loadQuestions()
        }
    }
    
    private func loadQuestions() {
        let url = Bundle.main.url(forResource: "questions", withExtension: "json")!
        
        do {
            let data = try Data(contentsOf: url)
            // decode the questions
            allQuestions = try JSONDecoder().decode([Question].self, from: data)
            questions = Array(allQuestions.shuffled().prefix(10))
        } catch {
            print(error)
        }
    }
}

struct Question: Codable, Identifiable {
    var id = UUID()
    let prompt: String
    let A: String
    let B: String
    let C: String
    let D: String
    let answer: String
    
    var answerText: String {
        return switch answer {
            case "A": A
            case "B": B
            case "C": C
            case "D": D
            default: ""
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case prompt, A, B, C, D, answer
    }
}

#Preview {
    ContentView()
}
