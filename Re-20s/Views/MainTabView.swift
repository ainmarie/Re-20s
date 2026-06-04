import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: MainTab = .home

    var body: some View {
        ZStack {
            switch selectedTab {
            case .home:
                HomeView()
            case .record:
                RecordView()
            case .solution:
                SolutionView()
            case .my:
                MyPageView()
            }

            VStack {
                Spacer()

                FloatingTabBar(selectedTab: $selectedTab)
                    .padding(.horizontal, 22)
                    .padding(.bottom, 14)
            }
        }
    }
}

enum MainTab: String, CaseIterable {
    case home = "홈"
    case record = "기록"
    case solution = "솔루션"
    case my = "마이"

    var icon: String {
        switch self {
        case .home:
            return "house"
        case .record:
            return "calendar"
        case .solution:
            return "leaf"
        case .my:
            return "person"
        }
    }

    var selectedIcon: String {
        switch self {
        case .home:
            return "house.fill"
        case .record:
            return "calendar.circle.fill"
        case .solution:
            return "leaf.fill"
        case .my:
            return "person.fill"
        }
    }
}

struct FloatingTabBar: View {
    @Binding var selectedTab: MainTab

    var body: some View {
        HStack(spacing: 0) {
            ForEach(MainTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.spring(response: 0.32, dampingFraction: 0.82)) {
                        selectedTab = tab
                    }
                } label: {
                    VStack(spacing: 5) {
                        Image(systemName: selectedTab == tab ? tab.selectedIcon : tab.icon)
                            .font(.system(size: 18, weight: .semibold))

                        Text(tab.rawValue)
                            .font(.system(size: 11, weight: .semibold))
                    }
                    .foregroundColor(selectedTab == tab ? .white : Re20sColor.subText)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(
                        Group {
                            if selectedTab == tab {
                                RoundedRectangle(cornerRadius: 22)
                                    .fill(
                                        LinearGradient(
                                            colors: [
                                                Re20sColor.sage,
                                                Re20sColor.neoMint
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .shadow(color: Re20sColor.sage.opacity(0.20), radius: 10, x: 0, y: 5)
                            }
                        }
                    )
                }
            }
        }
        .padding(7)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white.opacity(0.74))
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Re20sColor.warmWhite.opacity(0.72))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.white.opacity(0.75), lineWidth: 1)
                )
                .shadow(color: Re20sColor.sage.opacity(0.18), radius: 20, x: 0, y: 10)
        )
    }
}

#Preview {
    MainTabView()
        .environmentObject(AppState())
}
