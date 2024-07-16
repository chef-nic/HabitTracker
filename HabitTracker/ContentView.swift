//
//  ContentView.swift
//  HabitTracker
//
//  Created by Nicholas Johnson on 7/15/24.
//

import SwiftUI

struct ContentView: View {
    @State private var data = Activities()
    @State private var addingNewActivity = false

    var body: some View {
        NavigationStack {
            List(data.activities) { activity in
                NavigationLink {
                    ActivityView(data: data, activity: activity)
                } label: {
                    HStack {
                        Text(activity.title)
                            .font(.caption.weight(.black))
                            .padding(5)
                            .frame(minWidth: 50)
                            .background(color(for: activity))
                            .foregroundStyle(.white)
                            .clipShape(.capsule)
                        Spacer()

                        Text(String(activity.completionCount))
                    }
                }
            }
            .navigationTitle("Habito")
            .toolbar {
                Button("Add new activity", systemImage: "plus") {
                    addingNewActivity.toggle()
                }
            }
            .sheet(isPresented: $addingNewActivity) {
                AddActivity(data: data)
            }
        }
    }
    
    func color(for activity: Activity) -> Color {
        if activity.completionCount < 3 {
            return .red
        } else if activity.completionCount < 10 {
            return .orange
        } else if activity.completionCount < 20 {
            return .green
        } else if activity.completionCount < 50 {
            return .blue
        } else {
            return .indigo
        }
    }
}


#Preview {
    ContentView()
}




struct ActivityView: View {
    var data: Activities
    var activity: Activity

    var body: some View {
        List {
            if activity.description.isEmpty == false {
                Section {
                    Text(activity.description)
                }
            }

            Section {
                Text("Completion count: \(activity.completionCount)")

                Button("Mark Completed") {
                    var newActivity = activity
                    newActivity.completionCount += 1

                    if let index = data.activities.firstIndex(of: activity) {
                        data.activities[index] = newActivity
                    }
                }
            }
        }
        .navigationTitle(activity.title)
    }
}
