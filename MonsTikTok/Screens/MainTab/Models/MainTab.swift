import SwiftUI

enum MainTab: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case home
    case shop
    case upload
    case inbox
    case profile
}

extension MainTab {
    static let allCases: [MainTab] = [.home, .shop, .inbox, .profile]
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
        case .shop:
                .handbag
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
        case .shop:
                .handbag.fill
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
}
