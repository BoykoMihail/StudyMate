//
//  QuestionEntity.swift
//  StudyMate
//
//  Created by Михаил Бойко on 18.01.2024.
//

import CoreData

public class QuestionEntity: NSManagedObject, Identifiable {
    @NSManaged public var question: String?
    @NSManaged public var answer: String?
    @NSManaged public var numberOfAttempts: Int16
    @NSManaged public var numberOfCorrectAnswers: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var createAt: Date?
}

//import CoreData
//
//extension QuestionEntity {
//    
//    public override func awakeFromInsert() {
//        super.awakeFromInsert()
//        self.id = UUID()
//        self.createdAt = Date()
//    }
//}
