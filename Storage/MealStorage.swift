import Foundation

final class MealStorage {

    private let storageKey = "WeeklyMealPlannerData"

    func save(_ meals: [Meal]) {
        do {
            let data = try JSONEncoder().encode(meals)
            UserDefaults.standard.set(data, forKey: storageKey)
        } catch {
            print("Saving error: \(error.localizedDescription)")
        }
    }

    func load() -> [Meal] {
        guard let data = UserDefaults.standard.data(
            forKey: storageKey
        ) else {
            return []
        }

        do {
            return try JSONDecoder().decode(
                [Meal].self,
                from: data
            )
        } catch {
            print("Loading error: \(error.localizedDescription)")
            return []
        }
    }
}
