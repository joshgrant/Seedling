// Copyright Team Seedling ©

import SwiftUI

struct SectionEditView: View {
    @ScaledMetric(relativeTo: .body) var titleSize: CGFloat = 22
    
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.sortIndex, order: SortOrder.forward)])
    private var sections: FetchedResults<TaskSection>
    
    var body: some View {
        List(sections, id: \.objectID) { section in
            VStack(alignment: .leading, spacing: 8) {
                Text(section.title ?? "")
                    .font(.system(size: titleSize).monospaced())
                    .fontWeight(.medium)
                Rectangle()
                    .fill(SeedlingAsset.orange.swiftUIColor)
                    .frame(height: 1)
            }
            .listRowSeparator(.hidden)
            .listRowInsets(.init(top: 0, leading: 20, bottom: -8.5, trailing: 0))
            .swipeActions {
                Button(role: .destructive) {
                    context.delete(section)
                    // TODO: Add a confirmation alert
                } label: {
                    Label(SeedlingStrings.delete.localizedCapitalized, systemImage: "trash")
                }
            }
        }
        .listStyle(.plain)
    }
}

struct SectionEditView_Previews: PreviewProvider {
    
    static let database = Database(containerName: "Seedling")
    
    static var previews: some View {
        SectionEditView()
            .environment(\.managedObjectContext, database.context)
    }
}
