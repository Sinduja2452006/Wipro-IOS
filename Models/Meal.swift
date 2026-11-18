import Foundation

enum Weekday: String, CaseIterable, Codable, Identifiable {
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
    case sunday = "Sunday"

    var id: String { rawValue }
}

enum MealType: String, CaseIterable, Codable, Identifiable {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case snacks = "Snacks"

    var id: String { rawValue }

    var sortOrder: Int {
        switch self {
        case .breakfast: return 0
        case .lunch: return 1
        case .dinner: return 2
        case .snacks: return 3
        }
    }

    var symbol: String {
        switch self {
        case .breakfast: return "sunrise.fill"
        case .lunch: return "sun.max.fill"
        case .dinner: return "moon.stars.fill"
        case .snacks: return "carrot.fill"
        }
    }

    var imageName: String {
        switch self {
        case .breakfast: return "BreakfastMeal"
        case .lunch: return "LunchMeal"
        case .dinner: return "DinnerMeal"
        case .snacks: return "SnacksMeal"
        }
    }
}

enum MealStatus: String, CaseIterable, Codable, Identifiable {
    case planned = "Planned"
    case cooked = "Cooked"
    case skipped = "Skipped"

    var id: String { rawValue }
}

struct Meal: Identifiable, Codable, Hashable {

    var id: UUID = UUID()
    var dishName: String
    var day: Weekday
    var mealType: MealType
    var servings: Int
    var notes: String
    var status: MealStatus = .planned
}
