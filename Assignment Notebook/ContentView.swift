//
//  ContentView.swift
//  Assignment Notebook
//
//  Created by Carson Payne on 1/24/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var assignmentList = AssignmentList()
    @State private var showingAddAssignmentView = false
    @State var selectedColor = Color.blue
    var body: some View {
        NavigationView {
            List {
                ForEach(assignmentList.items) { item in
                    HStack {
                        VStack(alignment: .leading, content: {
                            Text(item.course).font(.headline)
                            Text(item.description)
                        })
                        Spacer()
                        Text(item.dueDate,style: .date)
                        Circle()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(selectedColor)
                    }
                    
                }
                .onMove(perform: { indices, newOffset in
                    assignmentList.items.move(fromOffsets: indices, toOffset: newOffset)
                })
                .onDelete(perform: { indexSet in
                    assignmentList.items.remove(atOffsets: indexSet)
                })
            }
            .sheet(isPresented: $showingAddAssignmentView, content: {
                AddAssignmentView(assignmentList: assignmentList)
            })
            .navigationBarTitle("Assignment Notebook", displayMode: .inline)
            .navigationBarItems(leading: EditButton(),
            trailing: Button(action: {
                showingAddAssignmentView = true
            }, label: {
                Image(systemName: "plus")
            }))
        }
    }
}

#Preview {
    ContentView()
}
struct AssignmentItem: Identifiable, Codable{
    var id = UUID()
    var course = String()
    var color = String()
    var description = String()
    var dueDate = Date()
    
}
