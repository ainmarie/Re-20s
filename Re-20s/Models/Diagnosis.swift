import SwiftUI

enum CoreType: String, CaseIterable, Identifiable {
    case comparison = "C"
    case overload = "O"
    case room = "R"
    case ethos = "E"

    var id: String {
        rawValue
    }

    var name: String {
        switch self {
        case .comparison:
            return "타인비교형"
        case .overload:
            return "시스템과로형"
        case .room:
            return "환경압박형"
        case .ethos:
            return "트렌드동조형"
        }
    }

    var fullName: String {
        switch self {
        case .comparison:
            return "C. 타인비교형"
        case .overload:
            return "O. 시스템과로형"
        case .room:
            return "R. 환경압박형"
        case .ethos:
            return "E. 트렌드동조형"
        }
    }
}
