import SwiftUI

struct TaskCell: View {
    @EnvironmentObject var dataHolder: DataHolder
    @ObservedObject var taskItem: TaskItem
    
    var body: some View {
        CheckBoxView(taskItem: taskItem)
            .environmentObject(dataHolder)
        
        Text(taskItem.name ?? "")
            .padding(.horizontal)
    }
}

struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskCell(taskItem: TaskItem())
    }
}
