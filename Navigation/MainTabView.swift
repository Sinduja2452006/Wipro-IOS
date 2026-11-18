

import SwiftUI

struct MainTabView: View {

    var body: some View {

        TabView {

            NavigationStack {
                DashboardView()
            }
            .tabItem {
                Label("Dashboard", systemImage: "house.fill")
            }

            NavigationStack {
                MealListView()
            }
            .tabItem {
                Label("Meal Plans", systemImage: "calendar")
            }
        }
        .tint(.green)
    }
}
