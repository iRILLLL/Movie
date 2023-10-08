import SwiftUI

struct TrendingCarouselView<
    Content: View, Items, ID
>: View where Items: RandomAccessCollection,
              Items.Element: Equatable,
              ID: Hashable {
    
    private let padding: CGFloat
    private let spacing: CGFloat
    private let items: Items
    private let id: KeyPath<Items.Element, ID>
    private let content: (Items.Element, CGSize) -> Content
    
    init(
        padding: CGFloat,
        spacing: CGFloat,
        items: Items,
        id: KeyPath<Items.Element, ID>,
        content: @escaping (Items.Element, CGSize) -> Content
    ) {
        self.padding = padding
        self.spacing = spacing
        self.items = items
        self.id = id
        self.content = content
    }
    
    var body: some View {
        GeometryReader { proxy in
            
            let width = proxy.size.width * 0.75
            let height = width * 16 / 9
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: spacing) {
                    ForEach(items, id: id) { item in
                        content(item, CGSize(width: width, height: height))
                    }
                }
                .padding([.leading, .trailing], spacing)
            }
        }
    }
}
