//
//  ModuleEntity.swift
//  StudyMate
//
//  Created by Михаил Бойко on 18.01.2024.
//

import Foundation
import CoreData

@objc(ModuleEntity)
public class ModuleEntity: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ModuleEntity> {
        return NSFetchRequest<ModuleEntity>(entityName: "ModuleEntity")
    }

    @NSManaged public var createAt: Date
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var questions: Set<QuestionEntity>

    public convenience init(
        context: NSManagedObjectContext,
        name: String,
        questions: Set<QuestionEntity> = Set<QuestionEntity>()
    ) {
        let entity = NSEntityDescription.entity(forEntityName: "ModuleEntity", in: context)!
        self.init(entity: entity, insertInto: context)
        self.id = UUID()
        self.createAt = Date()
        self.name = name
        self.questions = questions
    }
    
    public convenience init(context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entity(forEntityName: "ModuleEntity", in: context)!
        self.init(entity: entity, insertInto: context)
        self.id = UUID()
        self.createAt = Date()
        self.name = "Module Title"
        self.questions = Set<QuestionEntity>()
    }
}

extension ModuleEntity {

    @objc(addQuestionsObject:)
    @NSManaged public func addToQuestions(_ value: QuestionEntity)

    @objc(removeQuestionsObject:)
    @NSManaged public func removeFromQuestions(_ value: QuestionEntity)

    @objc(addQuestions:)
    @NSManaged public func addToQuestions(_ values: NSSet)

    @objc(removeQuestions:)
    @NSManaged public func removeFromQuestions(_ values: NSSet)

}

extension ModuleEntity : Identifiable { }

extension ModuleEntity {

    func addQuestion(_ question: QuestionEntity) {
        question.module = self
        self.addToQuestions(question)
    }

    func editModule(with name: String) {
        self.name = name
    }

    func removeQuestion(_ question: QuestionEntity) {
        guard self.questions.contains(question) else {
            return
        }

        self.removeFromQuestions(question)
        question.module = nil
    }
}
