//
//  ModuleEntity.swift
//  StudyMate
//
//  Created by Михаил Бойко on 18.01.2024.
//

import CoreData

//extension ModuleEntity {
//    
//    public override func awakeFromInsert() {
//        super.awakeFromInsert()
//        self.id = UUID()
//        self.createdAt = Date()
//    }
//}
public class ModuleEntity: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID
    @NSManaged public var createAt: Date
    @NSManaged public var name: String
    @NSManaged public var questions: Set<QuestionEntity>
    
    convenience init(context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entity(forEntityName: "ModuleEntity", in: context)!
        self.init(entity: entity, insertInto: context)

        self.id = UUID()
        self.createAt = Date()
        self.questions = Set<QuestionEntity>()
    }
}
