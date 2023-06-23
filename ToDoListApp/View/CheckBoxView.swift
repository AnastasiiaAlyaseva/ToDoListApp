import SwiftUI

struct CheckBoxView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dataHolder: DataHolder
    @ObservedObject var taskItem: TaskItem

    var body: some View {
        let isTaskCompleted = taskItem.isCompleted
        Image(systemName: isTaskCompleted ? "checkmark.circle.fill" : "circle")
            .foregroundColor(isTaskCompleted ? .green : .secondary)
            .onTapGesture {
                withAnimation {
                    if isTaskCompleted {
                        taskItem.completedDate = nil
                    } else {
                        taskItem.completedDate = Date()
                    }
                    dataHolder.saveContext(viewContext)
                }
            }
    }
}

struct CheckBoxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxView(taskItem: TaskItem())
    }
}
