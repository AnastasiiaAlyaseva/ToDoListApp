import SwiftUI

struct CheckBoxView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder
    @ObservedObject var passedTaskItem: TaskItem
    @State private var isChecked:Bool = false
    
    var body: some View {
        Image(systemName: passedTaskItem.isCompleted() ? "checkmark.circle.fill" : "circle")
            .foregroundColor(passedTaskItem.isCompleted() ? .green : .secondary)
            .onTapGesture {
                withAnimation{
                    isChecked.toggle()
                    if isChecked {
                        passedTaskItem.completedDate = Date()
                        dateHolder.saveContext(viewContext)
                    } else {
                        passedTaskItem.completedDate = nil
                        dateHolder.saveContext(viewContext)
                    }
                }
            }
    }
}

struct CheckBoxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxView(passedTaskItem: TaskItem())
    }
}
