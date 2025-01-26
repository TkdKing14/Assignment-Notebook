//
//  AddAssignmentView.swift
//  Assignment Notebook
//
//  Created by Carson Payne on 1/25/25.
//

import SwiftUI

struct AddAssignmentView: View {
    @Environment(\.presentationMode) var presentationMode
    static let courses = ["History", "Science", "Math", "English"]
//    static let colors = ["Blue", "Red", "Green"]
    @ObservedObject var assignmentList: AssignmentList
    @State private var course = ""
    @State private var description = ""
    @State private var color = ""
    @State private var dueDate = Date()
    @State var selectedColor = Color.blue
    var body: some View {
        NavigationView {
                Form {
                    Picker("Course", selection: $course) {
                        ForEach(Self.courses, id: \.self) { course in
                            Text(course)
                        }
//                                            ForEach(Self.colors, id: \.self) { color in
//                                                Text(color)
//                                            }
                    }
                    TextField("Description", text: $description)
                    DatePicker ("Due Date", selection: $dueDate, displayedComponents: .date)
                    ColorPicker("Pick Color", selection: $selectedColor)
                }
                .navigationBarTitle("Add New Assignment Item", displayMode: .inline)
                .navigationBarItems (trailing: Button ("Save") {
                    if course.count > 0 && description.count > 0 {
                        let item = AssignmentItem(id: UUID(), course: course,
                                                  color: color, description: description, dueDate: dueDate)
                        assignmentList.items.append(item)
                        presentationMode.wrappedValue.dismiss ()
                    }
                })
        }
    }
}

#Preview {
    AddAssignmentView(assignmentList: AssignmentList())
}

