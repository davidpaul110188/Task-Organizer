import SwiftUI

struct ConfigEventView: View {
    
    @EnvironmentObject private var viewModel: TaskViewModel
    @Binding var currentPage: Int
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title: String = ""
    @State private var length: Int = 0
    @State private var theme: Color = .green
    let colors = [Color.green, Color.red, Color.gray, Color.blue, Color.brown, Color.cyan]
    
    var body: some View {
        VStack {
            Form{
                Group {
                    Section {
                        TextField(
                            "Title",
                            text: $title
                        ).padding(.all)
                    }
                    Section {
                        TextField(
                            "Length",
                            value: $length,
                            formatter: NumberFormatter()
                        ).padding(.all)
                    }
                    Section {
                        Picker("Theme", selection: $theme) {
                            ForEach(colors, id: \.self) { color in
                                Text(color.description)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                }
                .onAppear {
                    if(currentPage != -1) {
                        title = viewModel.tasks[currentPage].title
                        length = viewModel.tasks[currentPage].length / 60
                        theme = viewModel.tasks[currentPage].theme
                    }
                }
            }
            HStack {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                Button("Save") {
                    let toMinutes = length * 60
                    if(currentPage != -1) {
                        viewModel.tasks[currentPage].title = title
                        viewModel.tasks[currentPage].length = toMinutes
                        viewModel.tasks[currentPage].theme = theme
                    } else {
                        viewModel.addTask(task:
                                            TaskModel(
                                                title: title,
                                                theme: theme,
                                                length: toMinutes
                                            ),
                                          time: TimeModel()
                        )
                    }
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(incompleteForm())
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
        }
        .toolbar {
//            if(currentPage != -1) {
//                Button {
//                    viewModel.tasks.remove(at: currentPage)
//                    viewModel.times.remove(at: currentPage)
//                    presentationMode.wrappedValue.dismiss()
//                } label: {
//                    Image(systemName: "trash").font(.system(size: 30, weight: .black))
//                }
//            }
        }
    }
    
    func incompleteForm() -> Bool {
        if(length == 0 || title.isEmpty) {
            return true
        }
        
        return false
    }
}

//struct ConfigEventView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConfigEventView()
//    }
//}
