

import SwiftUI

struct AddMealView: View {

    @EnvironmentObject var viewModel: MealViewModel
    @Environment(\.dismiss) var dismiss

    @State private var dishName = ""
    @State private var day: Weekday = .monday
    @State private var mealType: MealType = .breakfast
    @State private var servings = 1
    @State private var notes = ""

    var body: some View {

        MealFormView(
            dishName: $dishName,
            day: $day,
            mealType: $mealType,
            servings: $servings,
            notes: $notes
        )
        .navigationTitle("Add Meal")
        .toolbar {

            ToolbarItem(placement: .cancellationAction) {

                Button("Cancel") {
                    dismiss()
                }
            }

            ToolbarItem(placement: .confirmationAction) {

                Button("Save") {

                    viewModel.addMeal(
                        dishName: cleanDishName,
                        day: day,
                        mealType: mealType,
                        servings: servings,
                        notes: notes
                    )

                    dismiss()
                }
                .disabled(cleanDishName.isEmpty)
            }
        }
    }

    // MARK: - Clean Dish Name

    private var cleanDishName: String {
        dishName.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
    }
}
