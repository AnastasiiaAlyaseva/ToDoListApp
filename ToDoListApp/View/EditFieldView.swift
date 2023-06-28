import SwiftUI

struct EditFieldView: View {
    @Binding var name: String
    @State private var isNameEmpty = false
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Taks Name", text: $name)
                .onChange(of: name) { newValue in
                    isNameEmpty = newValue.isEmpty
                }
            
            if isNameEmpty {
                Text("Cannot be empty")
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }
}

struct EditFieldView_Previews: PreviewProvider {
    static var previews: some View {
        EditFieldView(name: .constant("Anastasiia"))
    }
}
