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
                        VStack {
                            VStack(alignment: .leading, content: {
                                Text(item.course).font(.headline)
                                    .foregroundStyle(Color.white)
                                    .fontWeight(.bold)
                                Text(item.description)
                                    .foregroundStyle(Color.primary.opacity(0.7))
                            })
                            .padding(10)
                            .background(Color.blue)
                            .cornerRadius(10)
                        }
                        .padding(3)
                        .background(Color.black)
                        .cornerRadius(10)
                            Spacer()
                        VStack {
                            Text(item.dueDate,style: .date)
                                .foregroundColor(Color.white)
                                .padding(10)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .italic()
                                .fontWeight(.bold)
                        }
                        .padding(3)
                        .background(Color.black)
                        .cornerRadius(10)
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
