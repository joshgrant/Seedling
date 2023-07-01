// Copyright Team Seedling ©

import SwiftUI
import CoreData

protocol ListEditable: Entity
{
    var title: String? { get set }
}

struct EntityListEditView<E: ListEditable>: View
{
    struct Configuration
    {
        var title: String
        var deleteTitle: String
        var deleteMessage: String
        static var taskSection: Configuration {
            .init(title: Strings.editSections, deleteTitle: Strings.deleteSection, deleteMessage: Strings.deleteSectionMessage)
        }
        static var mealType: Configuration {
            .init(title: Strings.editMealTypes, deleteTitle: Strings.deleteMealType, deleteMessage: Strings.deleteMealTypeMessage)
        }
    }
    
    @ScaledMetric(relativeTo: .body) var textSize: CGFloat = 22
    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: [SortDescriptor(\.sortIndex, order: SortOrder.forward)])
    private var entities: FetchedResults<E>
    @FocusState var focus: NSManagedObjectID?
    @State var focusEntity: NSManagedObject?
    @State var deleteAlert: Bool = false
    @State var swipeEntity: NSManagedObject?
    var configuration: Configuration
    var addEntity: (Context) -> NSManagedObject
    var deleteEntity: (Context, NSManagedObject) -> Void
    var onDismiss: ((Context, NSManagedObject) -> Void)? = nil

    var body: some View
    {
        List(entities, id: \.objectID) { entity in
            VStack(alignment: .leading, spacing: 8) {
                SwiftUI.TextField("", text: Binding<String>(get: {
                    entity.title ?? ""
                }, set: { newText in
                    entity.title = newText
                }))
                .focused($focus, equals: entity.objectID)
                .font(.system(size: textSize, weight: .medium).monospaced())
                .onSubmit {
                    dismissKeyboard()
                }
                Rectangle()
                    .fill(SeedlingAsset.orange.swiftUIColor)
                    .frame(height: 1)
            }
            .listRowSeparator(.hidden)
            .listRowInsets(.init(top: 0, leading: 20, bottom: -7, trailing: 0))
            .swipeActions {
                Button() {
                    deleteAlert = true
                    swipeEntity = entity
                } label: {
                    Label(Strings.delete.localizedCapitalized, systemImage: "trash")
                }
                .tint(.red)
            }
            .confirmationDialog(configuration.deleteTitle, isPresented: $deleteAlert, actions: {
                Button(configuration.deleteTitle, role: .destructive) {
                    if let swipeEntity = swipeEntity {
                        deleteEntity(context, swipeEntity)
                        focus = nil
                        focusEntity = nil
                        self.swipeEntity = nil
                    }
                }
            } , message: {
                Text(configuration.deleteMessage)
            })
        }
        
        .onTapGesture {
            dismissKeyboard()
        }
        .listStyle(.plain)
        .navigationTitle(configuration.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    let entity = addEntity(context)
                    focus = entity.objectID
                    focusEntity = entity
                } label: {
                    Label(Strings.add, systemImage: "plus.circle")
                }
                
            }
        }
        .scrollDismissesKeyboard(.interactively)
    }
    
    private func dismissKeyboard()
    {
        if let focusEntity = focusEntity as? ListEditable
        {
            if focusEntity.title == nil || focusEntity.title?.isEmpty ?? false
            {
                deleteEntity(context, focusEntity)
            }
            else
            {
                onDismiss?(context, focusEntity)
            }
        }
        focus = nil
        focusEntity = nil
    }
}

struct EntityListEditView_Previews: PreviewProvider
{
    static let database = Database(containerName: "Seedling")
    
    static var previews: some View
    {
        NavigationStack {
            EntityListEditView<TaskSection>(configuration: .taskSection, addEntity: { context in
                let taskSection = TaskSection(context: context)
                let numTaskSections = TaskSection.allSections(in: context).count
                taskSection.sortIndex = Int32(numTaskSections)
                return taskSection
            }, deleteEntity: { context, entity in
                context.delete(entity)
            })
            .environment(\.managedObjectContext, database.context)
        }
    }
}
