//
//  UpdateTaskView.swift
//  TaskMa
//
//  Created by Isaias Cuvula on 12.03.22.
//

import SwiftUI
import RealmSwift

struct UpdateTaskView: View {
    
    let task: Task
    @State var taskTitle = ""
    @State var startDate = Date()
    @State var endDate = Date()
    @State var selectedPriority = ""
    @State var taskDescription = ""

    private let priorities: [String] = [
        "Low","Moderate", "Mediun", "High"
    ]
    @State private var deleteDialog = false
    @EnvironmentObject var viewModel: TaskViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                
                HStack{
                    Text("Task Title")
                        .font(.headline)
                    
                    Spacer()
                    
                    Button{
                        self.deleteDialog.toggle()
                    } label: {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                            .frame(width: 48, height: 48)
                    }
                    .alert("Delete this task?", isPresented: $deleteDialog) {
                        
                        HStack{
                            Button("YES", role: .destructive){
                                viewModel.deleteTask(id: task.id)
                                dismiss()
                            }
                            Spacer()
                            
                            Button("NO", role: .cancel) {}
                        }
                    }
                }
                
                TextField(task.title, text: $taskTitle)
                    .textFieldStyle(.roundedBorder)
                    .disableAutocorrection(true)
                
                DatePicker(selection: $startDate){
                    Text("Start Date")
                        .font(.headline)
                    
                }
                .padding(.vertical)
                
                DatePicker(selection: $endDate){
                    Text("Due Date")
                        .font(.headline)
                    
                }
                
                Picker("My Priority", selection: $selectedPriority) {
                    ForEach(priorities, id:\.self){ prior in
                        Text(prior)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.vertical)
                
                Text("Description")
                    .font(.headline)
                
                
                TextEditor(text: $taskDescription)
                    .disableAutocorrection(true)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemGray4), lineWidth: 3)
                    )
                
                let colorIndex = Int.random(in: 0...10)
                
                Button{
                    if taskTitle != "" {
                        viewModel.updateTask(id: task.id ,title: taskTitle, startDate: startDate, endDate: endDate, priority: selectedPriority, taskDescription: taskDescription, colorIndex: colorIndex)
                    }
                    
                    dismiss()
                    
                } label: {
                    Text("Update Task")
                        .padding()
                        .foregroundColor(.white)
                    
                }
                .frame(maxWidth: .infinity)
                .background(Color(.systemBlue))
                .cornerRadius(10)
            }
            .padding(.top)
            Spacer()
            
            
        }
        .padding()
        .onAppear {
            taskTitle = task.title
            startDate = task.startDate
            endDate = task.endDate
            selectedPriority = task.priority
            taskDescription = task.taskDescription
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UpdateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateTaskView(task: Task(value: ["taskTitle": "", "startDate": Date(), "endDate": Date(), "selectedPriority": "low", "taskDescription": "Date()"]))
    }
}
