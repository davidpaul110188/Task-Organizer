import Foundation
import SwiftUI

class TaskViewModel : ObservableObject{
    @Published var tasks = [TaskModel]()
    @Published var times = [TimeModel]()
    
    init() {
        runTimer()
    }
    
    
    func addTask(task: TaskModel, time: TimeModel) {
        tasks.append(task)
        times.append(time)
    }
    
    func startTimer(index: Int) {
        self.times[index].isRunning = true
    }
    
    func pauseTimer(index: Int) {
        self.times[index].isRunning = false
    }
    
    func pauseAll() {
        let length = self.tasks.count - 1
        if(length > -1) {
            for i in 0...length {
                self.times[i].isRunning = false
            }
        }
    }
    
    func stopTimer(index: Int) {
        self.times[index].isRunning = false
        self.times[index].elapse = 0
    }
    
    func runTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            DispatchQueue.main.async {
                let length = self.tasks.count - 1
                if(length > -1) {
                    for i in 0...length {
                        if(self.times[i].isRunning && self.times[i].elapse < self.tasks[i].length) {
                            self.times[i].elapse += 1
                        }
                    }
                }
            }
            
        }
    }
}

