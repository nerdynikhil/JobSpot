import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        VStack(spacing: 24) {
            Text("Welcome Back")
                .font(.title)
                .fontWeight(.bold)
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("LOGIN") {}
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(red: 26/255, green: 27/255, blue: 75/255))
                .foregroundColor(.white)
                .cornerRadius(12)
            Button("SIGN IN WITH GOOGLE") {}
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .foregroundColor(Color(red: 26/255, green: 27/255, blue: 75/255))
                .cornerRadius(12)
        }
        .padding()
    }
}

#Preview {
    LoginView()
} 