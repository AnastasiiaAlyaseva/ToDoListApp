import SwiftUI

// TODO: add icon

@main
struct ToDoListAppApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            let context = persistenceController.container.viewContext
            let dataHolder = DataHolder(context)
            
            TaskListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(dataHolder)
        }
    }
}
