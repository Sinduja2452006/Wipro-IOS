
import Foundation
import Combine

@MainActor
final class MealViewModel: ObservableObject {

    @Published private(set) var meals: [Meal] = []

    private let storage = MealStorage()

    init() {
        meals = storage.load()
    }

    private func saveChanges() {
        storage.save(meals)
    }

    // MARK: - Add Meal

    func addMeal(
        dishName: String,
        day: Weekday,
        mealType: MealType,
        servings: Int,
        notes: String
    ) {
        let meal = Meal(
            dishName: dishName,
            day: day,
            mealType: mealType,
            servings: servings,
            notes: notes
        )

        meals.append(meal)
        saveChanges()
    }

    // MARK: - Edit Meal

    func updateMeal(_ updatedMeal: Meal) {

        guard let index = meals.firstIndex(
            where: { $0.id == updatedMeal.id }
        ) else {
            return
        }

        meals[index] = updatedMeal
        saveChanges()
    }

    // MARK: - Delete Meal

    func deleteMeal(id: UUID) {
        meals.removeAll { $0.id == id }
        saveChanges()
    }

    // MARK: - Update Status

    func updateStatus(
        id: UUID,
        status: MealStatus
    ) {

        guard let index = meals.firstIndex(
            where: { $0.id == id }
        ) else {
            return
        }

        meals[index].status = status
        saveChanges()
    }

    // MARK: - Get Meal

    func getMeal(id: UUID) -> Meal? {
        meals.first { $0.id == id }
    }

    // MARK: - Sort Meals

    func sortedMeals() -> [Meal] {

        let days = Weekday.allCases

        return meals.sorted {

            let firstDay = days.firstIndex(of: $0.day) ?? 0
            let secondDay = days.firstIndex(of: $1.day) ?? 0

            if firstDay != secondDay {
                return firstDay < secondDay
            }

            return $0.mealType.sortOrder <
                   $1.mealType.sortOrder
        }
    }

    // MARK: - Search Meals

    func searchMeals(_ keyword: String) -> [Meal] {

        guard !keyword.isEmpty else {
            return sortedMeals()
        }

        return sortedMeals().filter {
            $0.dishName.localizedCaseInsensitiveContains(keyword)
        }
    }

    // MARK: - Filter Meals

    func filterMeals(
        day: Weekday?,
        mealType: MealType?
    ) -> [Meal] {

        return sortedMeals().filter { meal in

            let matchesDay = day == nil || meal.day == day

            let matchesType = mealType == nil ||
                              meal.mealType == mealType

            return matchesDay && matchesType
        }
    }

    // MARK: - Search and Filter

    func filteredMeals(
        keyword: String,
        day: Weekday?,
        mealType: MealType?
    ) -> [Meal] {

        return searchMeals(keyword).filter { meal in

            let matchesDay = day == nil || meal.day == day

            let matchesType = mealType == nil ||
                              meal.mealType == mealType

            return matchesDay && matchesType
        }
    }
}
