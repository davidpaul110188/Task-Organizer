import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = TaskViewModel()
    @State var index: Int = -1
    
    
    var body: some View {
        NavigationView {
            TaskListView()
                .navigationTitle("Daily Tasks")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        NavigationLink(destination: ConfigEventView(currentPage: $index).environmentObject(viewModel)) {
                            Image(systemName: "plus").font(.system(size: 30, weight: .black))
                        }
                    }
                }
                .environmentObject(viewModel)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
