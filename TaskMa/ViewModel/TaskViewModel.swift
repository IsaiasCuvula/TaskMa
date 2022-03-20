//
//  TaskViewModel.swift
//  TaskMa
//
//  Created by Isaias Cuvula on 12.03.22.
//

import SwiftUI
import RealmSwift


class TaskViewModel: ObservableObject {
    
    private var realm: Realm?
    @Published var tasks: [Task] = []
    @Published var filteredTasks: [Task] = []
    let  colors: [Color] = [.yellow, .red,
                            .blue, .cyan,
                            .green, .purple,
                            .gray, .orange,
                            .pink, .teal,
                            .brown]

    
    
    init(){
        openRealm()
        getAllTasks()
    }
    
    
    private func openRealm(){
        do {
            
            let config = Realm.Configuration(schemaVersion: 2)
            
            Realm.Configuration.defaultConfiguration = config
             realm = try Realm()
            
            
        } catch {
            print("Error openning Realm: \(error.localizedDescription)")
        }
    }
    
    func createTask(title: String, startDate: Date, endDate: Date,priority: String, taskDescription: String, colorIndex: Int){
        
        do {
            try realm?.write{
                
                let newTask = Task(value:
                                    ["title": title, "startDate": startDate,
                                     "endDate": endDate,"priority": priority,
                                     "taskDescription": taskDescription,
                                     "colorIndex": colorIndex]
                )
                
                realm?.add(newTask)
                getAllTasks()
            }
            
        }catch {
            print("Error while create a task: \(error.localizedDescription)")
        }
        
    }
    
    
    
    
    func updateTask(id: ObjectId ,title: String, startDate: Date, endDate: Date,priority: String, taskDescription: String, colorIndex: Int){
        if let realm = realm {
            do {
                
                let taskToUpdate = realm.objects(Task.self).filter(NSPredicate(format: "id == %@", id))
                guard !taskToUpdate.isEmpty else { return }
                
                
                try realm.write{
                    
                    taskToUpdate[0].title = title
                    taskToUpdate[0].startDate = startDate
                    taskToUpdate[0].endDate = endDate
                    taskToUpdate[0].priority = priority
                    taskToUpdate[0].taskDescription = taskDescription
                    getAllTasks()
                }
                
            }catch {
                print("Error while create a task: \(error.localizedDescription)")
            }
        }
    }
    
    func getAllTasks(){
        if let realm = realm {
            let allTasks = realm.objects(Task.self).sorted(byKeyPath: "title", ascending: true)
            tasks = []
            allTasks.forEach { task in
                tasks.append(task)
            }
        }
    }
    
    func deleteTask(id: ObjectId) {
        
        if let realm = realm {
            do {
                
                let taskToDelete = realm.objects(Task.self).filter(NSPredicate(format: "id == %@", id))
                guard !taskToDelete.isEmpty else { return }
                
                try realm.write{
                    realm.delete(taskToDelete)
                    getAllTasks()
                }
                
            } catch {
                print("Error deliting task: \(error.localizedDescription)")
            }
        }
    }
}
