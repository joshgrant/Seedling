// Copyright Team Seedling ©

import SwiftUI

protocol ListEditable: Entity
{
    var title: String? { get set }
}

struct EntityListEditView<E: ListEditable>: View
{
    
    @ScaledMetric(relativeTo: .body) var textSize: CGFloat = 22
    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: [SortDescriptor(\.sortIndex, order: SortOrder.forward)])
    private var entities: FetchedResults<E>
    var title: String
    var addEntity: (Context) -> Void
    
    var body: some View
    {
        List(entities, id: \.objectID) { entity in
            VStack(alignment: .leading, spacing: 8) {
                SwiftUI.TextField("", text: Binding<String>(get: {
                    entity.title ?? ""
                }, set: { newText in
                    entity.title = newText
                }))
                .font(.system(size: textSize, weight: .medium).monospaced())
                Rectangle()
                    .fill(SeedlingAsset.orange.swiftUIColor)
                    .frame(height: 1)
            }
            .listRowSeparator(.hidden)
            .listRowInsets(.init(top: 0, leading: 20, bottom: -7, trailing: 0))
            .swipeActions {
                Button(role: .destructive) {
                    context.delete(entity)
                    // TODO: Add a confirmation alert
                } label: {
                    Label(SeedlingStrings.delete.localizedCapitalized, systemImage: "trash")
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    addEntity(context)
                } label: {
                    Label(SeedlingStrings.add, systemImage: "plus.circle")
                }
                
            }
        }
        .scrollDismissesKeyboard(.interactively)
    }
}

struct EntityListEditView_Previews: PreviewProvider
{
    static let database = Database(containerName: "Seedling")
    
    static var previews: some View
    {
        NavigationStack {
            EntityListEditView<TaskSection>(title: "Task Section", addEntity: { context in
                let taskSection = TaskSection(context: context)
                let numTaskSections = TaskSection.allSections(in: context).count
                taskSection.sortIndex = Int32(numTaskSections)
            })
            .environment(\.managedObjectContext, database.context)
        }
    }
}
