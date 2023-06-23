import SwiftUI

struct FloatingButton: View {
    @EnvironmentObject var dataHolder: DataHolder
    
    var body: some View {
        Spacer ()
        HStack {
            NavigationLink (destination: TaskEditView(taskItem: nil, initalDate: Date())
                .environmentObject(dataHolder)) {
                    Text(" + New Task ")
                        .font(.headline)
                }
                .padding(15)
                .foregroundColor(.white)
                .background(Color.accentColor)
                .cornerRadius(30)
                .padding(30)
                .shadow(color: .black.opacity(0.3), radius: 3, x: 3, y: 3)
        }
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton()
    }
}
