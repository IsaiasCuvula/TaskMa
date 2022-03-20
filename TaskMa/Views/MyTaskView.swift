//
//  MyTaskView.swift
//  TaskMa
//
//  Created by Isaias Cuvula on 11.03.22.
//

import SwiftUI

struct MyTaskView: View {
    
    @EnvironmentObject var viewModel: TaskViewModel
    @State private var myDate = Date()
    private let priorities: [String] = [
        "All","Low","Moderate", "Mediun", "High"
    ]
    @State private var selectedPriority = "All"
    @State private var allTasks: [Task] = []
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .leading) {
                
                ZStack{
                    Color(.systemTeal)
                        .opacity(0.5)
                        .cornerRadius(10)
                    
                    Picker("Priorities",selection: $selectedPriority) {
                        ForEach(priorities, id: \.self){ priority in
                            Text(priority)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                }
              
                if allTasks.count == 0 {
                    ZStack{
                        Color(.systemBlue)
                            .cornerRadius(10)
                            .frame(height: 200)
                        
                        Text("Nothing to do on \(myDate.formatted(date: .abbreviated, time: .omitted)) ")
                            .font(.title2).bold()
                            .foregroundColor(.white)
                    }
                    .padding(.top)
                    Spacer()
                    
                } else {
                    ScrollView(.vertical, showsIndicators: false){
                        ForEach(selectedPriority == "All" ? allTasks :  allTasks.filter({$0.priority == selectedPriority})){task in
                            NavigationLink {
                                UpdateTaskView(task: task)
                            } label: {
                                TaskView(task: task)
                            }
                        }
                    }
                }
            }
        }
        .onAppear{
            updateUI()
        }
    }
    
    private func updateUI(){
        allTasks = viewModel.tasks.map{ task in
            Task(value: task)
        }
    }
}

struct MyTaskView_Previews: PreviewProvider {
    static var previews: some View {
        MyTaskView()
    }
}
