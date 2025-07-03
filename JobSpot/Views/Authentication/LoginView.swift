import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var showPassword = false
    @FocusState private var isEmailFocused: Bool
    @FocusState private var isPasswordFocused: Bool
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 26/255, green: 27/255, blue: 75/255),
                    Color(red: 45/255, green: 46/255, blue: 95/255)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                Spacer(minLength: 24)
                
                // Header
                VStack(spacing: 8) {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.1))
                            .frame(width: 80, height: 80)
                        
                        Image(systemName: "briefcase.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                    }
                    
                    VStack(spacing: 4) {
                        Text("Welcome Back")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        
                        Text("Sign in to continue your job search")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
                .padding(.bottom, 12)
                
                // Login Form
                VStack(spacing: 16) {
                    // Email field
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Email")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.white.opacity(0.9))
                        
                        HStack {
                            Image(systemName: "envelope")
                                .foregroundColor(.white.opacity(0.6))
                                .frame(width: 20)
                            
                            TextField("Enter your email", text: $email)
                                .textFieldStyle(PlainTextFieldStyle())
                                .foregroundColor(.white)
                                .focused($isEmailFocused)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        }
                        .padding(10)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(isEmailFocused ? Color.white.opacity(0.5) : Color.clear, lineWidth: 1)
                        )
                    }
                    
                    // Password field
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Password")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.white.opacity(0.9))
                        
                        HStack {
                            Image(systemName: "lock")
                                .foregroundColor(.white.opacity(0.6))
                                .frame(width: 20)
                            
                            if showPassword {
                                TextField("Enter your password", text: $password)
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .foregroundColor(.white)
                                    .focused($isPasswordFocused)
                            } else {
                                SecureField("Enter your password", text: $password)
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .foregroundColor(.white)
                                    .focused($isPasswordFocused)
                            }
                            
                            Button(action: {
                                showPassword.toggle()
                            }) {
                                Image(systemName: showPassword ? "eye.slash" : "eye")
                                    .foregroundColor(.white.opacity(0.6))
                            }
                        }
                        .padding(10)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(isPasswordFocused ? Color.white.opacity(0.5) : Color.clear, lineWidth: 1)
                        )
                    }
                    
                    // Forgot password
                    HStack {
                        Spacer()
                        Button("Forgot Password?") {
                            // Handle forgot password
                        }
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.white.opacity(0.8))
                    }
                }
                .padding(.bottom, 8)
                
                // Login button
                Button(action: {
                    Task {
                        isLoading = true
                        await authManager.login(email: email, password: password)
                        isLoading = false
                    }
                }) {
                    HStack {
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(0.8)
                        } else {
                            Text("Sign In")
                                .font(.system(size: 15, weight: .semibold))
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.white)
                    .foregroundColor(Color(red: 26/255, green: 27/255, blue: 75/255))
                    .cornerRadius(10)
                }
                .disabled(email.isEmpty || password.isEmpty || isLoading)
                .opacity((email.isEmpty || password.isEmpty) ? 0.6 : 1.0)
                .padding(.bottom, 4)
                
                // Divider
                HStack {
                    Rectangle()
                        .fill(Color.white.opacity(0.3))
                        .frame(height: 1)
                    Text("or")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.white.opacity(0.6))
                        .padding(.horizontal, 10)
                    Rectangle()
                        .fill(Color.white.opacity(0.3))
                        .frame(height: 1)
                }
                .padding(.vertical, 4)
                
                // Google Sign In
                Button(action: {
                    // Handle Google sign in
                }) {
                    HStack(spacing: 10) {
                        Image(systemName: "globe")
                            .foregroundColor(.white)
                        
                        Text("Continue with Google")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                    )
                }
                .padding(.bottom, 8)
                
                // Sign up link
                HStack {
                    Text("Don't have an account?")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.white.opacity(0.8))
                    
                    Button("Sign Up") {
                        // Navigate to sign up
                    }
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.white)
                }
                .padding(.top, 8)
                
                Spacer(minLength: 12)
            }
            .padding(.horizontal, 24)
            .frame(maxWidth: 400)
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthenticationManager())
} 