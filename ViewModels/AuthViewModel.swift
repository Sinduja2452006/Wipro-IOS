

import Foundation
import Combine
import LocalAuthentication

@MainActor
final class AuthViewModel: ObservableObject {

    enum AuthState {
        case checking
        case login
        case authenticated
    }

    @Published var state: AuthState = .checking

    @Published var errorMessage = ""

    private var hasStarted = false

    // MARK: - Face ID Authentication

    func startAuthentication() {

        guard !hasStarted else {
            return
        }

        hasStarted = true

        let context = LAContext()

        var error: NSError?

        let available = context.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            error: &error
        )

        guard available,
              context.biometryType == .faceID else {

            state = .login
            return
        }

        context.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "Access your weekly meal plan"
        ) { [weak self] success, authenticationError in

            Task { @MainActor [weak self] in

                guard let self = self else {
                    return
                }

                if success {
                    self.state = .authenticated
                } else {
                    self.errorMessage =
                        authenticationError?.localizedDescription
                        ?? "Authentication failed."

                    self.state = .login
                }
            }
        }
    }

    // MARK: - Local Login

    func login(
        username: String,
        password: String
    ) {

        let cleanUsername = username.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        if cleanUsername.isEmpty || password.isEmpty {

            errorMessage = "Please fill in all fields."
            return
        }

        if password.count < 6 {

            errorMessage =
                "Password must have at least 6 characters."

            return
        }

        errorMessage = ""
        state = .authenticated
    }
}
