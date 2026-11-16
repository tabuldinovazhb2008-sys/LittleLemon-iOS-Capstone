import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var firstName = UserDefaults.standard.string(forKey: "firstNameKey") ?? ""
    @State private var lastName = UserDefaults.standard.string(forKey: "lastNameKey") ?? ""
    @State private var email = UserDefaults.standard.string(forKey: "emailKey") ?? ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Personal information")
                .font(.title)
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("First name: \(firstName)")
                Text("Last name: \(lastName)")
                Text("Email: \(email)")
            }
            .padding()
            
            Button("Log out") {
                UserDefaults.standard.set(false, forKey: "isLoggedInKey")
                UserDefaults.standard.removeObject(forKey: "firstNameKey")
                UserDefaults.standard.removeObject(forKey: "lastNameKey")
                UserDefaults.standard.removeObject(forKey: "emailKey")
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Spacer()
        }
        .padding()
    }
}
