import SwiftUI
import CoreData

class DataHolder: ObservableObject {
    
    init(_ context: NSManagedObjectContext) {}
    
    func saveContext(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
