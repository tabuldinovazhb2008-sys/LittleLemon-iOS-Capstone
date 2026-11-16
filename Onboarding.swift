import SwiftUI

struct Onboarding: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var isLoggedIn = false

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                
                Text("Little Lemon")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                
                VStack(alignment: .leading, spacing: 10) {
                    TextField("First Name *", text: $firstName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Last Name *", text: $lastName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Email *", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()

                Button("Register") {
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                        UserDefaults.standard.set(firstName, forKey: "firstNameKey")
                        UserDefaults.standard.set(lastName, forKey: "lastNameKey")
                        UserDefaults.standard.set(email, forKey: "emailKey")
                        UserDefaults.standard.set(true, forKey: "isLoggedInKey")
                        isLoggedIn = true
                    }
                }
                .padding()
                .background(Color.yellow)
                .foregroundColor(.black)
                .cornerRadius(8)
                
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}
