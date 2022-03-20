//
//  CreateTask.swift
//  TaskMa
//
//  Created by Isaias Cuvula on 11.03.22.
//

import SwiftUI

struct CreateTask: View {
    @State private var taskTitle = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var selectedPriority = ""
    @State private var taskDescription = ""
    @State private var showAlert = false
    @EnvironmentObject var viewModel: TaskViewModel
    @Environment(\.dismiss) var dismiss
    private let priorities: [String] = [
        "Low","Moderate", "Mediun", "High"
    ]
    
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("Task Title")
                    .font(.headline)
                
                TextField("title ... ", text: $taskTitle)
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
                    .foregroundColor(.black)
                    .disableAutocorrection(true)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemGray4), lineWidth: 3)
                    )
                
                let colorIndex = Int.random(in: 0...10)
                
                Button{
                    if taskTitle != "" {
                        viewModel.createTask(title: taskTitle, startDate: startDate, endDate: endDate, priority: selectedPriority, taskDescription: taskDescription, colorIndex: colorIndex)
                    } else {
                        showAlert.toggle()
                    }
                    
                    dismiss()
                    
                    taskTitle = ""
                    taskDescription = ""
                    startDate = Date()
                    endDate = Date()
                    
                } label: {
                    Text("Create Task")
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
        .alert("Task title cannot be empty!",isPresented: $showAlert) {
            Button("OK",role: .cancel) {}
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CreateTask_Previews: PreviewProvider {
    static var previews: some View {
        CreateTask()
    }
}
