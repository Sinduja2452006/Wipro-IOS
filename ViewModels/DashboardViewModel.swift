

import Foundation
import Combine

@MainActor
final class DashboardViewModel: ObservableObject {

    private let mealViewModel: MealViewModel

    init(mealViewModel: MealViewModel) {
        self.mealViewModel = mealViewModel
    }

    // MARK: - Total Meals

    var totalMeals: Int {
        mealViewModel.meals.count
    }

    // MARK: - Cooked Meals

    var cookedMeals: Int {
        mealViewModel.meals.filter {
            $0.status == .cooked
        }.count
    }

    // MARK: - Pending Meals

    var pendingMeals: Int {
        mealViewModel.meals.filter {
            $0.status == .planned
        }.count
    }

    // MARK: - Next Upcoming Meal

    var nextUpcomingMeal: Meal? {

        mealViewModel.sortedMeals().first {
            $0.status == .planned
        }
    }
}
