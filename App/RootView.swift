
import SwiftUI

struct RootView: View {

    @StateObject private var authViewModel = AuthViewModel()

    var body: some View {

        Group {

            switch authViewModel.state {

            case .checking:
                ProgressView("Checking authentication...")

            case .login:
                LoginView()
                    .environmentObject(authViewModel)

            case .authenticated:
                MainTabView()
            }
        }
        .task {
            authViewModel.startAuthentication()
        }
    }
}
