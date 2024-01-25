//
//  Module.swift
//  StudyMate
//
//  Created by Михаил Бойко on 20.01.2024.
//

import SwiftUI

struct Module: View {
    @ObservedObject private var viewModel: ModuleViewModel

    init(viewModel: ModuleViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List {
            ForEach(viewModel.questions, id: \.id) { question in
                NavigationLink {

                } label: {
                    Text("Question is \(question.question)")
                }
            }
            .onDelete(perform: { indexSet in
                indexSet.forEach { index in
                    viewModel.deleteQuestion(at: index)
                }
            })
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: addItem) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
        .padding()
    }
    
    private func addItem() {
        viewModel.addQuestion(questionText: "Question")
    }
}
