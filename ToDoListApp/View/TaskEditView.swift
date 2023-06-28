import SwiftUI

// todo: bug save desc
struct TaskEditView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dataHolder: DataHolder
    
    @State private var selectedTaskItem: TaskItem?
    @State private var name: String
    @State private var desc: String
    @State private var dueDate: Date
    @State private var scheduleTime: Bool
    @State private var completedDate: Date?
    
    init(taskItem: TaskItem?, initalDate: Date) {
        _selectedTaskItem = State(initialValue: taskItem)
        _name = State(initialValue: taskItem?.name ?? "")
        _desc = State(initialValue: taskItem?.desc ?? "")
        _dueDate = State(initialValue: taskItem?.dueDate ?? initalDate)
        _scheduleTime = State(initialValue: taskItem?.scheduleTime ?? false)
        _completedDate = State(initialValue: taskItem?.completedDate)
    }
    
    var body: some View {
        let isCompletedTask: Bool = completedDate != nil
        
        Form {
            Section(header: Text("Task")) {
                EditFieldView(text: $name, placeholder: "Task Name")
                TextField("Desc", text: $desc, axis: .vertical)
            }
            Section(header: Text("Due Date")) {
                Toggle("Schedule Time", isOn: $scheduleTime)
                DatePicker(
                    "Due Date",
                    selection: $dueDate,
                    displayedComponents: displayComps()
                )
                
                if isCompletedTask, let completedDate: Binding<Date> = Binding($completedDate)  {
                    DatePicker(
                        "Completed Date",
                        selection: completedDate,
                        displayedComponents: displayComps()
                    )
                }
            }
            
            Section() {
                Button("Save", action: saveAction)
                    .disabled(name.isEmpty)
            }
        }
        .disabled(isCompletedTask)
    }
    
    private func displayComps() -> DatePickerComponents {
        return scheduleTime ? [.hourAndMinute, .date] : [.date]
    }
    
    private func saveAction() {
        withAnimation() {
            if selectedTaskItem == nil {
                selectedTaskItem = TaskItem(context: viewContext)
            }
            selectedTaskItem?.created = Date()
            selectedTaskItem?.name = name
            selectedTaskItem?.desc = desc
            selectedTaskItem?.dueDate = dueDate
            selectedTaskItem?.scheduleTime = scheduleTime
            
            dataHolder.saveContext(viewContext)
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct TaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        TaskEditView(taskItem: TaskItem(), initalDate: Date())
    }
}
