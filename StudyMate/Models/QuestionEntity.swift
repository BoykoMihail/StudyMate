//
//  QuestionEntity.swift
//  StudyMate
//
//  Created by Михаил Бойко on 18.01.2024.
//

import CoreData

@objc(QuestionEntity)
public class QuestionEntity: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuestionEntity> {
        return NSFetchRequest<QuestionEntity>(entityName: "QuestionEntity")
    }

    @NSManaged public var answer: String?
    @NSManaged public var createAt: Date
    @NSManaged public var id: UUID
    @NSManaged public var numberOfAttempts: Int16
    @NSManaged public var numberOfCorrectAnswers: Int16
    @NSManaged public var question: String
    @NSManaged public var module: ModuleEntity?
    
    public convenience init(context: NSManagedObjectContext, question: String, module: ModuleEntity? = nil) {
        let entity = NSEntityDescription.entity(forEntityName: "QuestionEntity", in: context)!
        self.init(entity: entity, insertInto: context)
        self.id = UUID()
        self.createAt = Date()
        self.question = question
        self.module = module
    }
    
    public convenience init(context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entity(forEntityName: "QuestionEntity", in: context)!
        self.init(entity: entity, insertInto: context)
        self.id = UUID()
        self.createAt = Date()
        self.question = "Question Title"
        self.module = nil
    }
}

extension QuestionEntity {
    func updateProperties(question: String? = nil, answer: String? = nil, numberOfAttempts: Int16? = nil, numberOfCorrectAnswers: Int16? = nil) {
        if let newQuestion = question {
            self.question = newQuestion
        }
        
        if let newAnswer = answer {
            self.answer = newAnswer
        }
        
        if let newAttempts = numberOfAttempts {
            self.numberOfAttempts = newAttempts
        }
        
        if let newCorrectAnswers = numberOfCorrectAnswers {
            self.numberOfCorrectAnswers = newCorrectAnswers
        }
    }
}
