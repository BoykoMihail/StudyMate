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
