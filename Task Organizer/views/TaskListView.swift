import SwiftUI

struct TaskListView: View {
    
    @EnvironmentObject private var viewModel: TaskViewModel
    
    @State var selection: String? = nil
    @State private var selectedPage = 0
    
    var body: some View {
        ZStack {
            NavigationLink(destination: TaskDetailView(currentPage: $selectedPage).environmentObject(viewModel),
                           tag: "Details",
                           selection: $selection) {
                EmptyView()
            }
            if(viewModel.tasks.count == 0) {
                Text("Empty Task")
            } else {
                List(viewModel.tasks.indices, id: \.self) { index in
                    HStack {
                        Text(viewModel.tasks[index].title)
                            .font(.system(size: 30))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack{
                            Text(String(viewModel.tasks[index].length / 60)).font(.system(size: 15, weight: .light))
                            Image(systemName: "clock").font(.system(size: 15, weight: .light))
                            Button {
                                selectedPage = index
                                self.selection = "Details"
                            } label: {
                                Image(systemName: "chevron.right").font(.system(size: 15, weight: .light))
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .listRowBackground(viewModel.tasks[index].theme)
                }
            }
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
