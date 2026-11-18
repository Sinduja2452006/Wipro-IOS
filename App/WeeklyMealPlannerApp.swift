
import SwiftUI

@main
struct WeeklyMealPlannerApp: App {

    @StateObject private var mealViewModel = MealViewModel()

    var body: some Scene {

        WindowGroup {
            MainTabView()
                .environmentObject(mealViewModel)
        }
    }
}

