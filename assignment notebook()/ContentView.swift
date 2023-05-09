//
//  ContentView.swift
//  assignment notebook()
//
//  Created by isa bolanos on 5/8/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var assignmentList = AssignmentList()
    @State private var showingAddAssignmentView = false
    @State private var items = ["First Item", "Second Item", "Third Item", "Fourth Item", "First Item"]
    var body: some View {
        NavigationView {
            List {
                ForEach(assignmentList.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.course)
                                .font(.headline)
                            Text(item.description)
                            
                        }
                        Spacer()
                        Text(item.dueDate, style: .date)
                        
                    }
                }
                .onMove { indices, newOffset in assignmentList.items.move(fromOffsets: indices, toOffset: newOffset)
                }
                .onDelete { indexSet in assignmentList.items.remove(atOffsets: indexSet)
                }
            }
            .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
            .preferredColorScheme(.dark)
            .sheet(isPresented: $showingAddAssignmentView, content: {
                AddAssignmentView(assignmentList: assignmentList)
            })
            .navigationBarTitle("Items", displayMode: .inline)
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                showingAddAssignmentView = true}) {
                    Image(systemName: "plus")
                })
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct AssignmentItem: Identifiable, Codable {
    var id = UUID()
    var course = String()
    var description = String()
    var dueDate = Date()
}
