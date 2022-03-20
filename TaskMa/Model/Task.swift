//
//  Task.swift
//  TaskMa
//
//  Created by Isaias Cuvula on 12.03.22.
//

import Foundation
import RealmSwift
import SwiftUI

class Task: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var priority: String
    @Persisted var taskDescription: String
    @Persisted var startDate: Date
    @Persisted var endDate: Date
    @Persisted var colorIndex: Int
    
}
