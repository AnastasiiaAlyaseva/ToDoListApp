import SwiftUI

extension TaskItem {
    
    var isCompleted: Bool {
        return completedDate != nil
    }
    
}
