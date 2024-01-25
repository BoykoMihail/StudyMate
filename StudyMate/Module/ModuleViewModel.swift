//
//  ModuleViewModel.swift
//  StudyMate
//
//  Created by Михаил Бойко on 25.01.2024.
//

import Foundation

class ModuleViewModel: ObservableObject {
    @Published var module: ModuleEntity
    @Published private var internalQuestions: [QuestionEntity] = []

    var questions: [QuestionEntity] {
        internalQuestions
    }
    
    init(module: ModuleEntity) {
        self.module = module
        self.internalQuestions = module.questions.sorted(by: { $0.createAt < $1.createAt })
    }

    func addQuestion(questionText: String) {
        let newQuestion = QuestionEntity(context: module.managedObjectContext!)
        newQuestion.question = questionText

        module.addQuestion(newQuestion)
        
        do {
            try module.managedObjectContext?.save()
            internalQuestions = module.questions.sorted(by: { $0.createAt < $1.createAt })
        } catch {
            print("Ошибка при сохранении: \(error)")
        }
    }

    func deleteQuestion(at index: Int) {
        let question = questions[index]
        module.removeQuestion(question)

        do {
            try module.managedObjectContext?.save()
            internalQuestions = module.questions.sorted(by: { $0.createAt < $1.createAt })
        } catch {
            print("Ошибка при сохранении: \(error)")
        }
    }
}

