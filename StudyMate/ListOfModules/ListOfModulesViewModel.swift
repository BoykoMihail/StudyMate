//
//  ListOfModulesViewModel.swift
//  StudyMate
//
//  Created by Михаил Бойко on 18.01.2024.
//

import CoreData

class QuestionViewModel: ObservableObject {
    @Published var modules: [ModuleEntity] = []

    func fetchModules() {
        let fetchRequest: NSFetchRequest<ModuleEntity> = ModuleEntity.fetchRequest()

        do {
            let fetchedModules = try CoreDataStack.shared.context.fetch(fetchRequest)
                debugPrint("BBoyko = ", type(of: fetchedModules))
                if let modules = fetchedModules as? [ModuleEntity] {
                    modules.forEach { element in
                        debugPrint("BBoyko id = ", element.id)
                        debugPrint("BBoyko name = ", element.name)
                        debugPrint("BBoyko createAt = ", element.createAt)
                        debugPrint("BBoyko questions = ", element.questions.count)
                    }
                }
                self.modules = fetchedModules
        } catch {
            print("Error fetching modules: \(error.localizedDescription)")
        }
    }

    func addModule(name: String) {
        let _ = ModuleEntity(context: CoreDataStack.shared.context, name: name)
        do {
            try CoreDataStack.shared.context.save()
        } catch {
            print("Error saving new module: \(error.localizedDescription)")
        }
    }

    func deleteModule(at index: Int) {
        let moduleToDelete = modules[index]

        CoreDataStack.shared.context.delete(moduleToDelete)

        do {
            try CoreDataStack.shared.context.save()
        } catch {
            print("Error deleting module: \(error.localizedDescription)")
        }
    }
}
