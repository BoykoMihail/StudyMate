//
//  ListOfModules.swift
//  StudyMate
//
//  Created by Михаил Бойко on 18.01.2024.
//

import SwiftUI

struct ListOfModules: View {
    @ObservedObject private var viewModel = QuestionViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.modules, id: \.self) { item in
                    NavigationLink {
                        Text("Item at \(item.name)")
                    } label: {
                        Text(item.name)
                    }
                }
                .onDelete(perform: { indexSet in
                    indexSet.forEach { index in
                        viewModel.deleteModule(at: index)
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
            Text("Select an item")
        }
        .onAppear {
            viewModel.fetchModules()
        }
    }

    private func addItem() {
        viewModel.addModule(name: "Module")
        viewModel.fetchModules()
    }
}

#Preview {
    ListOfModules()
}
