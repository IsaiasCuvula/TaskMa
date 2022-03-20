//
//  TaskView.swift
//  TaskMa
//
//  Created by Isaias Cuvula on 12.03.22.
//

import SwiftUI

struct TaskView: View {
    @EnvironmentObject var viewModel: TaskViewModel
    let task: Task
    
    var body: some View {
        
        VStack(alignment: .leading){
            Text(task.title)
                .font(.headline)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .foregroundColor(.black)
            
            Text(task.taskDescription)
                .padding(.top, 5)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .foregroundColor(.black)
            
            Divider()
            Text("Priority: \(task.priority)")
                .foregroundColor(.black)
            Divider()
            
            Text("\(task.startDate.formatted(date: .omitted, time: .shortened)) - \(task.endDate.formatted(date: .omitted, time: .shortened))")
                .foregroundColor(.black)
        
        }
        .padding()
        .background(viewModel.colors[task.colorIndex].opacity(0.5))
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(.systemBlue), lineWidth: 1)
        )
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(task: Task(value: ["title": "title", "startDate": "12.03.2022","endDate": "23.06.2022","priority": "high",
              "taskDescription": "taskDescription"]))
            .previewLayout(.sizeThatFits)
    }
}
