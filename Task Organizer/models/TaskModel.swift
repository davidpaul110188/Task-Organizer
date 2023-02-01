import Foundation
import SwiftUI

struct TaskModel: Hashable {
    let id = UUID()
    var title: String
    var theme: Color
    var length: Int // to be saved in seconds
}
