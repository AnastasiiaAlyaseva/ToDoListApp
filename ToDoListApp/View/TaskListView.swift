import SwiftUI
import CoreData

struct TaskListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dataHolder: DataHolder
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \TaskItem.dueDate, ascending: true)
        ],
        animation: .default
    )
    private var items: FetchedResults<TaskItem>
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    List {
                        ForEach(items) { taskItem in
                            NavigationLink (
                                destination:
                                    TaskEditView(taskItem: taskItem, initalDate: Date())
                                    .environmentObject(dataHolder)
                            ) {
                                TaskCell(taskItem: taskItem)
                                    .environmentObject(dataHolder)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            if items.count > 0 {
                                EditButton()
                            }
                        }
                    }
                    FloatingButton()
                        .environmentObject(dataHolder)
                }
            }.navigationTitle("ToDo List")
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            dataHolder.saveContext(viewContext)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
