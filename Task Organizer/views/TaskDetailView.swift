import SwiftUI

struct TaskDetailView: View {
    
    @EnvironmentObject private var viewModel: TaskViewModel
    @Binding var currentPage: Int
    @State var selection: String? = nil
    
    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(viewModel.tasks.indices) { i in
                var remaining = viewModel.tasks[i].length - viewModel.times[i].elapse
                var remainingMinutes = remaining / 60
                
                var elapseMinutes = viewModel.times[i].elapse / 60
                var elapseSeconds = viewModel.times[i].elapse - elapseMinutes * 60
                var displayText = "\(elapseMinutes) : \(elapseSeconds)"
                ZStack {
                    NavigationLink(destination: ConfigEventView(currentPage: $currentPage).environmentObject(viewModel),
                                   tag: "Config",
                                   selection: $selection) {
                        EmptyView()
                    }
                    
                    VStack {
                        HStack {
                            VStack {
                                Text("Minutes Elapsed")
                                HStack {
                                    Image(systemName: "timer").font(.system(size: 30, weight: .black))
                                    Text(String(viewModel.times[i].elapse / 60))
                                }
                            }
                            Spacer()
                            VStack {
                                Text("Minutes Remaining")
                                HStack {
                                    Text(String(remainingMinutes))
                                    Image(systemName: "timer").font(.system(size: 30, weight: .black))
                                }
                            }
                        }
                        
                        Spacer()
                        
                        Group {
                            VStack {
                                Text(viewModel.tasks[i].title).font(.system(size: 45))
                                    .padding()
                                Text(displayText).font(.system(size: 100))
                                    .padding()
                                HStack {
                                    Text("Minutes")
                                        .padding()
                                    Text("Seconds")
                                        .padding()
                                }
                            }
                        }
                        .padding(.top, 75)
                        
                        Group{
                            HStack {
                                Button(action: {
                                    viewModel.stopTimer(index: i)
                                }, label: {
                                    Image(systemName: "stop.circle").font(.system(size: 50, weight: .black))
                                })
                                
                                Button(action: {
                                    viewModel.startTimer(index: i)
                                }, label: {
                                    Image(systemName: "play.circle").font(.system(size: 100, weight: .black))
                                })
                                
                                Button(action: {
                                    viewModel.pauseTimer(index: i)
                                }, label: {
                                    Image(systemName: "pause.circle").font(.system(size: 50, weight: .black))
                                })
                            }
                        }
                        .padding(.bottom, 50)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(viewModel.tasks[i].theme)
                }.tag(i)
            }
        }
        .tabViewStyle(.page)
        .toolbar {
            Button(action: {
                viewModel.pauseAll()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.selection = "Config"
                }
            }, label: {
                Text("Edit")
            })
        }
    }
}
