

import SwiftUI

struct EditMealView: View {

    @EnvironmentObject var viewModel: MealViewModel
    @Environment(\.dismiss) private var dismiss

    let meal: Meal

    @State private var dishName: String
    @State private var day: Weekday
    @State private var mealType: MealType
    @State private var servings: Int
    @State private var notes: String

    // MARK: - Initializer

    init(meal: Meal) {

        self.meal = meal

        _dishName = State(initialValue: meal.dishName)
        _day = State(initialValue: meal.day)
        _mealType = State(initialValue: meal.mealType)
        _servings = State(initialValue: meal.servings)
        _notes = State(initialValue: meal.notes)
    }

    // MARK: - User Interface

    var body: some View {

        MealFormView(
            dishName: $dishName,
            day: $day,
            mealType: $mealType,
            servings: $servings,
            notes: $notes
        )
        .navigationTitle("Edit Meal")
        .toolbar {

            // Cancel Button

            ToolbarItem(placement: .cancellationAction) {

                Button("Cancel") {
                    dismiss()
                }
            }

            // Update Button

            ToolbarItem(placement: .confirmationAction) {

                Button("Update") {

                    updateMeal()
                }
                .disabled(
                    dishName.trimmingCharacters(
                        in: .whitespacesAndNewlines
                    ).isEmpty || servings < 1
                )
            }
        }
    }

    // MARK: - Update Meal

    private func updateMeal() {

        var updatedMeal = meal

        updatedMeal.dishName = dishName.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        updatedMeal.day = day
        updatedMeal.mealType = mealType
        updatedMeal.servings = servings
        updatedMeal.notes = notes

        viewModel.updateMeal(updatedMeal)

        dismiss()
    }
}
