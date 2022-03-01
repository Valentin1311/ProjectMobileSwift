import Foundation

class DynamicTabViewModel: ObservableObject {
    @Published var tabItems: [StageDTO]
    
    init(tabItems: [StageDTO]) {
        self.tabItems = tabItems
    }
    
    func addTabItem(stage: StageDTO) {
        tabItems.append(stage)
    }
    
    func removeTabItem(index: Int) {
        tabItems.remove(at: index) 
    }
}
