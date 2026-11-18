
import SwiftUI

struct MealDetailView: View {

    @EnvironmentObject var viewModel: MealViewModel
    @Environment(\.dismiss) var dismiss

    let meal: Meal

    @State private var showEdit = false
    @State private var showDeleteConfirmation = false

    // MARK: - Current Meal

    private var currentMeal: Meal {
        viewModel.getMeal(id: meal.id) ?? meal
    }

    // MARK: - Body

    var body: some View {

        Form {

            // MARK: - Meal Information

            Section("Meal Information") {

                Image(currentMeal.mealType.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 180)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .listRowInsets(EdgeInsets())

                LabeledContent(
                    "Dish Name",
                    value: currentMeal.dishName
                )

                LabeledContent(
                    "Day",
                    value: currentMeal.day.rawValue
                )

                LabeledContent(
                    "Meal Type",
                    value: currentMeal.mealType.rawValue
                )

                LabeledContent(
                    "Servings",
                    value: "\(currentMeal.servings)"
                )
            }

            // MARK: - Meal Status

            Section("Meal Status") {

                Picker(
                    "Status",
                    selection: Binding(
                        get: {
                            currentMeal.status
                        },
                        set: { newStatus in
                            viewModel.updateStatus(
                                id: meal.id,
                                status: newStatus
                            )
                        }
                    )
                ) {

                    ForEach(MealStatus.allCases) { status in

                        Text(status.rawValue)
                            .tag(status)
                    }
                }
            }

            // MARK: - Notes

            Section("Notes") {

                Text(
                    currentMeal.notes.isEmpty
                    ? "No notes added"
                    : currentMeal.notes
                )
                .foregroundColor(.secondary)
            }

            // MARK: - Actions

            Section {

                Button {
                    showEdit = true
                } label: {

                    Label(
                        "Edit Meal",
                        systemImage: "pencil"
                    )
                }

                Button(role: .destructive) {
                    showDeleteConfirmation = true
                } label: {

                    Label(
                        "Delete Meal",
                        systemImage: "trash"
                    )
                }
            }
        }

        .navigationTitle("Meal Details")

        // MARK: - Edit Meal Sheet

        .sheet(isPresented: $showEdit) {

            NavigationStack {

                EditMealView(meal: currentMeal)
                    .environmentObject(viewModel)
            }
        }

        // MARK: - Delete Confirmation

        .confirmationDialog(
            "Delete this meal?",
            isPresented: $showDeleteConfirmation,
            titleVisibility: .visible
        ) {

            Button("Delete", role: .destructive) {

                viewModel.deleteMeal(id: meal.id)
                dismiss()
            }

            Button("Cancel", role: .cancel) { }
        }
    }
}
