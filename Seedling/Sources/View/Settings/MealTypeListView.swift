// Copyright Team Seedling ©

import SwiftUI

// TODO: A lot of duplication between this and SectionEditView

struct MealTypeListView: View {
    
    // MARK: - Variables
    
    @ScaledMetric(relativeTo: .body) var mealTextSize: CGFloat = 22
    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: [SortDescriptor(\.sortIndex, order: SortOrder.forward)])
    private var mealTypes: FetchedResults<MealType>
    
    var body: some View {
        List(mealTypes, id: \.objectID) { type in
            VStack(alignment: .leading, spacing: 8) {
                SwiftUI.TextField("", text: Binding<String>(get: {
                    type.title ?? ""
                }, set: { newText in
                    type.title = newText
                }))
                .font(.system(size: mealTextSize, weight: .medium).monospaced())
                Rectangle()
                    .fill(SeedlingAsset.orange.swiftUIColor)
                    .frame(height: 1)
            }
            .listRowSeparator(.hidden)
            .listRowInsets(.init(top: 0, leading: 20, bottom: -7, trailing: 0))
            .swipeActions {
                Button(role: .destructive) {
                    context.delete(type)
                    // TODO: Add a confirmation alert
                } label: {
                    Label(Strings.delete.localizedCapitalized, systemImage: "trash")
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle(Strings.mealTypes)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    addNewMealType()
                } label: {
                    Label(Strings.add, systemImage: "plus.circle")
                }
                
            }
        }
        .scrollDismissesKeyboard(.interactively)
    }
    
    func addNewMealType()
    {
        do {
            let numberOfMeals = try MealType.totalCount(in: context)
            let newMeal = MealType(context: context)
            newMeal.sortIndex = Int32(numberOfMeals + 1)
            try context.save()
        }
        catch
        {
            // TODO: Handle
        }
    }
}

struct MealTypeListView_Previews: PreviewProvider {
    
    static let database = Database(containerName: "Seedling")
    
    static var previews: some View {
        NavigationView {
            MealTypeListView()
                .environment(\.managedObjectContext, database.context)
        }
    }
}
