
import SwiftUI

struct LoginView: View {

    @EnvironmentObject var authViewModel: AuthViewModel

    @State private var username = ""
    @State private var password = ""

    var body: some View {

        VStack(spacing: 25) {

            Spacer()

            // App Logo

            Image(systemName: "fork.knife.circle.fill")
                .font(.system(size: 75))
                .foregroundColor(.green)

            // App Title

            Text("Weekly Meal Planner")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Plan your meals for the week")
                .foregroundColor(.secondary)

            // Username Field

            TextField("Username", text: $username)
                .textFieldStyle(.roundedBorder)

            // Password Field

            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)

            // Error Message

            if !authViewModel.errorMessage.isEmpty {

                Text(authViewModel.errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
            }

            // Login Button

            Button("Login") {

                authViewModel.login(
                    username: username,
                    password: password
                )
            }
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
            .cornerRadius(12)

            Spacer()
        }
        .padding(25)
    }
}
