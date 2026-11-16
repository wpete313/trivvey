//
//  QuestionView.swift
//  trivvey
//
//  Created by Will Peterson on 10/31/26.
//

import SwiftUI

struct QuestionView: View {
    let question: Question
    @State private var selectedAnswer: String? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Text(question.prompt)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
            ForEach([question.A, question.B, question.C, question.D], id: \.self) { option in
                Button {
                    selectedAnswer = option
                } label: {
                    Text(option)
                        .foregroundStyle(.black)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(getColor(option).opacity(0.3))
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
            
            Text(getText())
                .foregroundStyle(getColor(selectedAnswer ?? ""))
                .font(.title2)
        }
    }
    
    private func getColor(_ option: String) -> Color {
        if selectedAnswer == nil {return .gray}
        if option == question.answerText {return .green}
        return .red
    }
    
    private func getText() -> String {
        if selectedAnswer == nil {return ""}
        if selectedAnswer == question.answerText {return "Correct!"}
        return "Incorrect"
    }
}

//#Preview {
//    QuestionView()
//}
