import SwiftUI

enum MainTab: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case home
    case notification
    case upload
    case inbox
    case profile
}

extension MainTab {
    static let allCases: [MainTab] = [.home, .notification, .upload, .inbox, .profile]
}

extension MainTab {
    var title: String? {
        switch self {
        case .upload:
            nil
        default:
            rawValue.capitalizeFirstLetter()
        }
    }
    
    var unselectedImage: Image.SystemImage? {
        switch self {
        case .home:
                .house
        case .notification:
                .bell
        case .upload:
            nil
        case .inbox:
                .textBubble
        case .profile:
                .person
        }
    }
    
    var selectedImage: Image.SystemImage? {
        switch self {
        case .home:
                .house.fill
        case .notification:
                .bell.fill
        case .upload:
            nil
        case .inbox:
                .textBubble.fill
        case .profile:
                .person.fill
        }
    }
    
    var foregroundStyle: Color {
        switch self {
        case .home:
                .white
        default:
                .black
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .home:
                .black
        default:
                .white
        }
    }
    
    var navigationTitle: String {
        switch self {
        case .home:
            ""
        case .notification:
            "Notification"
        case .upload:
            ""
        case .inbox:
            "Messages"
        case .profile:
            "Profile"
        }
    }
    
    var isHiddenNavigationBar: Bool {
        switch self {
        case .home, .upload:
            true
        case .notification, .inbox, .profile:
            false
        }
    }
}
