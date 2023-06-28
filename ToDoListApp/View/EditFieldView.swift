import SwiftUI

struct EditFieldView: View {
    @Binding var text: String
    let placeholder: String
    @State private var isTextEmpty = false
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField(placeholder, text: $text)
                .onChange(of: text) { newValue in
                    isTextEmpty = newValue.isEmpty
                }
            
            if isTextEmpty {
                Text("Cannot be empty")
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }
}

struct EditFieldView_Previews: PreviewProvider {
    static var previews: some View {
        EditFieldView(text: .constant("Anastasiia"), placeholder: "")
    }
}
