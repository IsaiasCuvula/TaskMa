//
//  ContentView.swift
//  TaskMa
//
//  Created by Isaias Cuvula on 11.03.22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showDarkMode = false
    @AppStorage("isDarkMode") var isDark = false
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                HStack{
                    Text("My Tasks")
                        .font(.largeTitle).bold()
                    
                    Spacer()
                    Button{
                        isDark.toggle()
                    } label: {
                        isDark ? Label("", systemImage: "lightbulb.fill") :
                        Label("", systemImage: "lightbulb")
                    }
                    
                    NavigationLink{
                        CreateTask()
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .frame(width: 26, height: 26)
                    }
                    .frame(width: 80, height: 80)
                    
                }
                Spacer()
                MyTaskView()
            }
            .padding()
            .navigationBarHidden(true)
            .preferredColorScheme(isDark ? .dark : .light)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
