//
//  AddAssignmentView.swift
//  assignment notebook()
//
//  Created by isa bolanos on 5/8/23.
//

import SwiftUI

struct AddAssignmentView: View {
    @ObservedObject var assignmentList: AssignmentList
    @State private var course = ""
    @State private var description = ""
    @State private var dueDate = Date()
    @Environment(\.presentationMode) var presentationMode
    static let courses = ["Math", "Computer Science", "English"]
    var body: some View {
        NavigationView {
            Form {
                Picker("Course", selection: $course) {
                    ForEach(Self.courses, id: \.self) { course in
                        Text(course)
                    }
                }
                TextField("Description", text: $description)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
            }
            .navigationBarTitle("Add Assignment", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                if course.count > 0 && description.count > 0 {
                    let assignment = AssignmentItem(id: UUID(), course: course, description: description, dueDate: dueDate)
                    assignmentList.items.append(assignment)
                    presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}

struct AddAssignmentView_Previews: PreviewProvider {
    static var previews: some View {
        AddAssignmentView(assignmentList: AssignmentList())
    }
}
