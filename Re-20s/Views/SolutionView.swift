import SwiftUI
import PhotosUI
import UIKit

struct SolutionView: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedTab: SolutionTab = .solution

    private var myCoreType: CoreType? {
        guard appState.hasDiagnosisResult else {
            return nil
        }

        return CoreType.allCases.first {
            $0.name == appState.diagnosisResultType
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Re20sBackground()

                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("솔루션")
                            .font(.system(size: 30, weight: .heavy))
                            .foregroundColor(Re20sColor.ink)

                        Text("내 유형에 맞는 미션과 커뮤니티를 확인해요.")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(Re20sColor.subText)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Picker("솔루션 탭", selection: $selectedTab) {
                        Text("솔루션").tag(SolutionTab.solution)
                        Text("커뮤니티").tag(SolutionTab.community)
                    }
                    .pickerStyle(.segmented)

                    if selectedTab == .solution {
                        SolutionContentView(myCoreType: myCoreType)
                    } else {
                        CommunityContentView(myCoreType: myCoreType)
                    }

                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 28)
                .padding(.bottom, 110)
            }
            .navigationBarHidden(true)
        }
    }
}

enum SolutionTab {
    case solution
    case community
}

// MARK: - 솔루션 데이터

struct SolutionItem: Identifiable {
    let id = UUID()
    let coreType: CoreType
    let title: String
    let description: String
    let guide: String
}

let allSolutionItems: [SolutionItem] = [
    SolutionItem(
        coreType: .comparison,
        title: "디지털 디톡스 미션",
        description: "SNS와 비교 자극을 잠시 줄이고, 나의 생활 리듬을 회복하는 미션입니다.",
        guide: "하루 30분 동안 SNS 사용을 멈추고, 그 시간에 산책·정리·독서처럼 나에게 집중하는 활동을 해보세요."
    ),
    SolutionItem(
        coreType: .comparison,
        title: "자기 성취 사진일기",
        description: "남과 비교하기보다 오늘 내가 해낸 일을 사진과 짧은 문장으로 기록하는 활동입니다.",
        guide: "오늘 완성한 일, 정리한 공간, 먹은 식사, 공부한 흔적 등 작은 성취를 사진으로 남기고 한 줄로 기록해보세요."
    ),
    SolutionItem(
        coreType: .overload,
        title: "명상 챌린지",
        description: "과도한 정보와 업무 자극에서 벗어나 마음을 잠시 멈추는 챌린지입니다.",
        guide: "하루 5분 동안 눈을 감고 호흡에 집중하세요. 알림은 잠시 꺼두고, 아무것도 하지 않는 시간을 만들어보세요."
    ),
    SolutionItem(
        coreType: .overload,
        title: "휴식 미션",
        description: "생산성 중심의 생활에서 벗어나 회복을 위한 휴식을 실천하는 미션입니다.",
        guide: "오늘 하루 중 20분을 정해 의도적으로 쉬어보세요. 휴식 시간에는 공부, 업무, 자기계발 콘텐츠를 보지 않습니다."
    ),
    SolutionItem(
        coreType: .room,
        title: "1인가구 맞춤형 공간 배치 챌린지",
        description: "나의 라이프스타일에 맞춰 1인 가구 원룸 구조에 어울리는 가구 배치를 추천받고, 실제 내 방을 정리해보는 챌린지입니다.",
        guide: "오늘 내 방에서 하고 싶은 핵심 활동을 선택하면, 활동에 맞는 원룸 공간 배치 가이드를 확인할 수 있어요. 이후 내 방 사진과 한 줄 후기를 남겨 인증해보세요."
    ),
    SolutionItem(
        coreType: .room,
        title: "청년월세 지원정책",
        description: "주거비 부담을 줄이기 위해 청년 대상 월세 지원정책을 확인하는 솔루션입니다.",
        guide: "거주 지역의 청년월세 지원 조건, 신청 기간, 필요 서류를 확인하고 나에게 해당되는 정책이 있는지 점검해보세요."
    ),
    SolutionItem(
        coreType: .ethos,
        title: "수원시 문화센터 연계",
        description: "온라인 유행보다 실제 지역 활동을 통해 건강한 취향과 관계를 회복하는 솔루션입니다.",
        guide: "수원시 문화센터나 청년 프로그램에서 관심 있는 강좌를 찾아보고, 나의 취향에 맞는 활동을 하나 선택해보세요."
    ),
    SolutionItem(
        coreType: .ethos,
        title: "건강한 취향 기록 챌린지",
        description: "무작정 유행을 따라가는 대신, 유행과 상관없이 내가 좋아하는 취향을 기록하는 챌린지입니다.",
        guide: "내가 좋아하는 노래, 패션, 취미, 공간, 물건 등을 사진과 글로 기록해보세요."
    )
]

// MARK: - 관련 운영기관 / 플랫폼 데이터

struct OrganizationItem: Identifiable {
    let id = UUID()
    let coreType: CoreType
    let name: String
    let activity: String
    let summary: String
    let urlString: String
}

let allOrganizationItems: [OrganizationItem] = [
    OrganizationItem(
        coreType: .comparison,
        name: "청년바람지대",
        activity: "청년 교류 프로그램 · 커뮤니티 활동 · 네트워킹 지원",
        summary: "또래 청년들과의 오프라인 교류와 관계 회복 활동을 지원해요.",
        urlString: "https://www.swyouth.kr"
    ),
    OrganizationItem(
        coreType: .comparison,
        name: "청누리",
        activity: "청년 정보 제공 · 활동 연결 · 참여 프로그램 안내",
        summary: "청년에게 필요한 정책과 활동 정보를 한곳에서 확인할 수 있어요.",
        urlString: "https://www.swyouth.kr"
    ),
    OrganizationItem(
        coreType: .overload,
        name: "정신건강복지센터",
        activity: "심리 상담 · 정신건강 검사 · 스트레스 관리 지원",
        summary: "과로와 불안, 번아웃을 겪는 청년이 전문적인 도움을 받을 수 있어요.",
        urlString: "https://www.mentalhealth.go.kr"
    ),
    OrganizationItem(
        coreType: .room,
        name: "수원 청년 포털",
        activity: "청년 주거정책 · 월세 지원 · 독립생활 정보 제공",
        summary: "주거비 부담과 독립생활 정보를 확인하고 지원사업으로 연결돼요.",
        urlString: "https://www.swyouth.kr"
    ),
    OrganizationItem(
        coreType: .ethos,
        name: "문화공간",
        activity: "문화 프로그램 · 취향 기반 활동 · 로컬 체험 연결",
        summary: "유행보다 나의 취향을 찾을 수 있는 문화 활동을 경험할 수 있어요.",
        urlString: "https://www.suwon.go.kr"
    ),
    OrganizationItem(
        coreType: .ethos,
        name: "청년 커뮤니티",
        activity: "청년 모임 · 취향 기반 네트워킹 · 지역 커뮤니티 활동",
        summary: "비슷한 관심사를 가진 청년들과 건강한 관계망을 만들 수 있어요.",
        urlString: "https://www.swyouth.kr"
    )
]

// MARK: - 솔루션 메인

struct SolutionContentView: View {
    let myCoreType: CoreType?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                if let myCoreType {
                    NavigationLink {
                        SolutionDetailView(coreType: myCoreType)
                    } label: {
                        Re20sGlassCard {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("나는 \(myCoreType.name)")
                                    .font(.system(size: 20, weight: .heavy))
                                    .foregroundColor(Re20sColor.ink)

                                Text("나에게 맞는 추천 솔루션 보기 →")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(Re20sColor.deepSage)
                            }
                        }
                    }
                } else {
                    Re20sGlassCard {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("아직 테스트를 진행하지 않았어요!")
                                .font(.system(size: 20, weight: .heavy))
                                .foregroundColor(Re20sColor.ink)

                            Text("CORE 진단을 완료하면 나에게 맞는 솔루션을 확인할 수 있어요.")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(Re20sColor.subText)

                            NavigationLink {
                                DiagnosisView()
                            } label: {
                                Text("테스트 바로 하러가기")
                                    .font(.system(size: 15, weight: .bold))
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 14)
                                    .background(
                                        LinearGradient(
                                            colors: [
                                                Re20sColor.sage,
                                                Re20sColor.neoMint
                                            ],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .foregroundColor(.white)
                                    .cornerRadius(18)
                            }
                        }
                    }
                }

                Re20sSectionTitle("유형별 솔루션")

                VStack(spacing: 12) {
                    ForEach(CoreType.allCases) { type in
                        NavigationLink {
                            SolutionDetailView(coreType: type)
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(type.fullName)
                                        .font(.system(size: 17, weight: .bold))
                                        .foregroundColor(Re20sColor.ink)

                                    Text("솔루션과 관련 기관 보기")
                                        .font(.caption)
                                        .foregroundColor(Re20sColor.subText)
                                }

                                Spacer()

                                Image(systemName: "chevron.right")
                                    .foregroundColor(Re20sColor.sage)
                            }
                            .padding()
                            .background(Color.white.opacity(0.55))
                            .cornerRadius(18)
                        }
                    }
                }

                Re20sSectionTitle("추천 사이트")

                VStack(spacing: 12) {
                    Link(destination: URL(string: "https://www.1388.go.kr")!) {
                        RecommendedSiteRow(
                            title: "청소년 상담 1388",
                            subtitle: "청소년·청년 상담 지원 사이트로 이동"
                        )
                    }

                    Link(destination: URL(string: "https://www.suwon.go.kr")!) {
                        RecommendedSiteRow(
                            title: "수원시 플랫폼",
                            subtitle: "수원시 공식 홈페이지로 이동"
                        )
                    }

                    Link(destination: URL(string: "https://www.swyouth.kr")!) {
                        RecommendedSiteRow(
                            title: "수원시 청년 지원 센터",
                            subtitle: "청년 정책·공간·프로그램 정보를 확인해요"
                        )
                    }
                }

                Spacer(minLength: 40)
            }
            .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct RecommendedSiteRow: View {
    let title: String
    let subtitle: String

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Re20sColor.ink)

                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(Re20sColor.subText)
            }

            Spacer()

            Image(systemName: "arrow.up.right.square.fill")
                .foregroundColor(Re20sColor.sage)
        }
        .padding()
        .background(Color.white.opacity(0.55))
        .cornerRadius(18)
    }
}

// MARK: - 유형별 솔루션 목록 + 관련 기관

struct SolutionDetailView: View {
    let coreType: CoreType

    private var solutions: [SolutionItem] {
        allSolutionItems.filter { $0.coreType == coreType }
    }

    private var organizations: [OrganizationItem] {
        allOrganizationItems.filter { $0.coreType == coreType }
    }

    var body: some View {
        ZStack {
            Re20sBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: 26) {
                    headerSection
                    solutionSection
                    organizationSection

                    Spacer(minLength: 90)
                }
                .padding(24)
            }
        }
        .navigationTitle("\(coreType.rawValue)형 솔루션")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var headerSection: some View {
        Re20sGlassCard {
            VStack(alignment: .leading, spacing: 10) {
                Text(coreType.fullName)
                    .font(.system(size: 24, weight: .heavy))
                    .foregroundColor(Re20sColor.deepSage)

                Text("추천 솔루션과 연결 가능한 운영기관·플랫폼을 함께 확인해요.")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Re20sColor.subText)
                    .lineSpacing(4)
            }
        }
    }

    private var solutionSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Re20sSectionTitle(
                "추천 솔루션",
                subtitle: "내 유형에 맞는 2가지 실천 미션이에요."
            )

            VStack(spacing: 12) {
                ForEach(solutions) { solution in
                    NavigationLink {
                        SolutionExplanationView(solution: solution)
                    } label: {
                        HStack(spacing: 12) {
                            ZStack {
                                Circle()
                                    .fill(Re20sColor.sage.opacity(0.16))
                                    .frame(width: 42, height: 42)

                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(Re20sColor.sage)
                            }

                            VStack(alignment: .leading, spacing: 5) {
                                Text(solution.title)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Re20sColor.ink)

                                Text("상세 설명과 미션 인증 보기")
                                    .font(.caption)
                                    .foregroundColor(Re20sColor.subText)
                            }

                            Spacer()

                            Image(systemName: "chevron.right")
                                .foregroundColor(Re20sColor.sage)
                        }
                        .padding()
                        .background(Color.white.opacity(0.56))
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white.opacity(0.72), lineWidth: 1)
                        )
                    }
                }
            }
        }
    }

    private var organizationSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Re20sSectionTitle(
                "관련 운영기관 · 플랫폼",
                subtitle: "유형별로 연결하면 좋은 지역 자원이에요."
            )

            VStack(spacing: 12) {
                ForEach(organizations) { organization in
                    NavigationLink {
                        OrganizationDetailView(organization: organization)
                    } label: {
                        OrganizationBlock(organization: organization)
                    }
                }
            }
        }
    }
}

// MARK: - 기관 / 플랫폼 블럭

struct OrganizationBlock: View {
    let organization: OrganizationItem

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            ZStack {
                Circle()
                    .fill(Re20sColor.neoMint.opacity(0.16))
                    .frame(width: 48, height: 48)

                Image(systemName: iconName)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Re20sColor.deepSage)
            }

            VStack(alignment: .leading, spacing: 7) {
                Text(organization.name)
                    .font(.system(size: 17, weight: .heavy))
                    .foregroundColor(Re20sColor.ink)

                Text(organization.activity)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(Re20sColor.deepSage)
                    .fixedSize(horizontal: false, vertical: true)

                Text(organization.summary)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(Re20sColor.subText)
                    .lineSpacing(3)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(Re20sColor.sage)
                .padding(.top, 4)
        }
        .padding(18)
        .background(Color.white.opacity(0.58))
        .cornerRadius(22)
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(Color.white.opacity(0.72), lineWidth: 1)
        )
        .shadow(color: Re20sColor.sage.opacity(0.08), radius: 12, x: 0, y: 6)
    }

    private var iconName: String {
        switch organization.coreType {
        case .comparison:
            return "person.2.fill"
        case .overload:
            return "heart.text.square.fill"
        case .room:
            return "house.fill"
        case .ethos:
            return "sparkles"
        }
    }
}

// MARK: - 기관 / 플랫폼 상세 페이지

struct OrganizationDetailView: View {
    let organization: OrganizationItem

    var body: some View {
        ZStack {
            Re20sBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Re20sGlassCard {
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                ZStack {
                                    Circle()
                                        .fill(Re20sColor.sage.opacity(0.16))
                                        .frame(width: 58, height: 58)

                                    Image(systemName: iconName)
                                        .font(.system(size: 26, weight: .bold))
                                        .foregroundColor(Re20sColor.deepSage)
                                }

                                Spacer()

                                Text(organization.coreType.rawValue)
                                    .font(.system(size: 16, weight: .heavy))
                                    .foregroundColor(.white)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 14)
                                    .background(Re20sColor.sage)
                                    .cornerRadius(16)
                            }

                            Text(organization.name)
                                .font(.system(size: 30, weight: .heavy))
                                .foregroundColor(Re20sColor.ink)

                            Text(organization.summary)
                                .font(.system(size: 15, weight: .regular))
                                .foregroundColor(Re20sColor.subText)
                                .lineSpacing(5)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }

                    Re20sGlassCard {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("활동 내용")
                                .font(.system(size: 20, weight: .heavy))
                                .foregroundColor(Re20sColor.ink)

                            Text(organization.activity)
                                .font(.system(size: 15, weight: .regular))
                                .foregroundColor(Re20sColor.subText)
                                .lineSpacing(5)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }

                    if let url = URL(string: organization.urlString) {
                        Link(destination: url) {
                            HStack {
                                Text("페이지로 이동")
                                    .font(.system(size: 16, weight: .bold))

                                Spacer()

                                Image(systemName: "arrow.up.right.square.fill")
                            }
                            .padding(.vertical, 16)
                            .padding(.horizontal, 18)
                            .background(
                                LinearGradient(
                                    colors: [
                                        Re20sColor.sage,
                                        Re20sColor.neoMint
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .foregroundColor(.white)
                            .cornerRadius(22)
                            .shadow(color: Re20sColor.sage.opacity(0.22), radius: 14, x: 0, y: 7)
                        }
                    }

                    Spacer(minLength: 80)
                }
                .padding(24)
            }
        }
        .navigationTitle("기관 정보")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var iconName: String {
        switch organization.coreType {
        case .comparison:
            return "person.2.fill"
        case .overload:
            return "heart.text.square.fill"
        case .room:
            return "house.fill"
        case .ethos:
            return "sparkles"
        }
    }
}

// MARK: - 솔루션 상세 설명

struct SolutionExplanationView: View {
    let solution: SolutionItem

    var body: some View {
        ZStack {
            Re20sBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Re20sSectionTitle(
                        solution.title,
                        subtitle: "솔루션 설명과 실천 방법을 확인해요."
                    )

                    Re20sGlassCard {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("솔루션 설명")
                                .font(.headline)
                                .foregroundColor(Re20sColor.ink)

                            Text(solution.description)
                                .foregroundColor(Re20sColor.subText)
                        }
                    }

                    Re20sGlassCard {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("실천 방법")
                                .font(.headline)
                                .foregroundColor(Re20sColor.ink)

                            Text(solution.guide)
                                .foregroundColor(Re20sColor.subText)
                        }
                    }

                    Re20sGlassCard {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("미션 인증 방식")
                                .font(.headline)
                                .foregroundColor(Re20sColor.ink)

                            Text(missionGuide(for: solution.title))
                                .font(.subheadline)
                                .foregroundColor(Re20sColor.subText)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }

                    NavigationLink {
                        MissionAuthView(solution: solution)
                    } label: {
                        Text("미션 참여하기")
                            .font(.system(size: 16, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                LinearGradient(
                                    colors: [
                                        Re20sColor.sage,
                                        Re20sColor.neoMint
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .foregroundColor(.white)
                            .cornerRadius(22)
                    }

                    Spacer(minLength: 80)
                }
                .padding(24)
            }
        }
        .navigationTitle("상세 설명")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func missionGuide(for title: String) -> String {
        switch title {
        case "디지털 디톡스 미션":
            return "스크린타임 캡처 이미지를 업로드하면 표준 포인트가 지급돼요."
        case "자기 성취 사진일기":
            return "오늘 이룬 작은 성취 사진과 한 줄 평을 함께 입력하면 표준 포인트가 지급돼요."
        case "명상 챌린지":
            return "앱 내 5분 타이머를 완료하고, 오늘 기분과 한 줄 평을 남기면 기본 마일리지가 지급돼요."
        case "휴식 미션":
            return "제공된 휴식 리스트 중 오늘 실천한 휴식을 선택하고, 기분과 한 줄 평을 남기면 기본 마일리지가 지급돼요."
        case "1인가구 맞춤형 공간 배치 챌린지":
            return "오늘 내 방에서 하고 싶은 핵심 활동을 선택하면 맞춤형 원룸 배치 가이드를 확인할 수 있어요. 이후 내 방 사진과 한 줄 후기를 입력하면 표준 포인트가 지급돼요."
        case "청년월세 지원정책":
            return "정책 링크 클릭 시 기본 포인트가 즉시 지급돼요. 실제 참여 인증 사진과 후기를 추가하면 고득점 포인트가 추가 지급돼요."
        case "수원시 문화센터 연계":
            return "문화센터 프로그램 링크 클릭 시 기본 포인트가 즉시 지급돼요. 참여 인증 사진과 후기를 추가하면 고득점 포인트가 추가 지급돼요."
        case "건강한 취향 기록 챌린지":
            return "유행과 상관없이 내가 좋아하는 것의 사진과 글을 기록하면 표준 포인트가 지급돼요."
        default:
            return "미션을 완료하면 CORE 포인트가 지급돼요."
        }
    }
}

// MARK: - 미션 인증 화면

struct MissionAuthView: View {
    @EnvironmentObject var appState: AppState

    let solution: SolutionItem

    @State private var selectedPhotoItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil

    @State private var reviewText: String = ""
    @State private var selectedMood: String = ""
    @State private var selectedRest: String = ""
    @State private var selectedLifestyle: String = ""

    @State private var timerSeconds: Int = 300
    @State private var isTimerRunning: Bool = false
    @State private var isTimerCompleted: Bool = false

    @State private var hasClickedExternalLink: Bool = false
    @State private var hasReceivedBasicPoint: Bool = false
    @State private var hasCompletedMission: Bool = false
    @State private var earnedPoint: Int = 0

    private let moods = ["좋아요", "보통이에요", "힘들었어요"]
    private let restOptions = ["산책하기", "낮잠 자기", "따뜻한 차 마시기", "음악 듣기", "멍 때리기", "스트레칭하기"]
    private let lifestyleOptions = ["홈트/운동", "요리/홈쿡", "휴식/넷플릭스", "재택근무/공부"]

    var body: some View {
        ZStack {
            Re20sBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Re20sSectionTitle(
                        solution.title,
                        subtitle: "미션을 인증하고 CORE 포인트를 받아요."
                    )

                    missionContent

                    if hasCompletedMission || hasReceivedBasicPoint {
                        completionBox
                    }

                    Spacer(minLength: 80)
                }
                .padding(24)
            }
        }
        .navigationTitle("미션 참여")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: selectedPhotoItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                    selectedImageData = data
                }
            }
        }
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            guard isTimerRunning else { return }

            if timerSeconds > 0 {
                timerSeconds -= 1
            } else {
                isTimerRunning = false
                isTimerCompleted = true
            }
        }
    }

    @ViewBuilder
    private var missionContent: some View {
        switch solution.title {
        case "디지털 디톡스 미션":
            imageUploadSection(title: "스크린타임 캡처 이미지 업로드")
            completeButton(point: 100, condition: selectedImageData != nil, disabledMessage: "스크린타임 캡처 이미지를 업로드해야 해요.")

        case "자기 성취 사진일기":
            imageUploadSection(title: "오늘 이룬 작은 성취 사진 업로드")
            textInputSection(title: "한 줄 평", placeholder: "오늘 내가 해낸 작은 성취를 적어주세요.")
            completeButton(point: 100, condition: selectedImageData != nil && !reviewText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, disabledMessage: "사진과 한 줄 평을 모두 입력해야 해요.")

        case "명상 챌린지":
            meditationTimerSection
            moodSection
            textInputSection(title: "한 줄 평", placeholder: "명상 후 느낀 점을 적어주세요.")
            completeButton(point: 50, condition: isTimerCompleted && !selectedMood.isEmpty && !reviewText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, disabledMessage: "5분 타이머 완료, 기분 선택, 한 줄 평이 필요해요.")

        case "휴식 미션":
            restSelectSection
            moodSection
            textInputSection(title: "한 줄 평", placeholder: "오늘의 휴식이 어땠는지 적어주세요.")
            completeButton(point: 50, condition: !selectedRest.isEmpty && !selectedMood.isEmpty && !reviewText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, disabledMessage: "휴식 선택, 기분 선택, 한 줄 평이 필요해요.")

        case "1인가구 맞춤형 공간 배치 챌린지":
            lifestyleSelectSection

            if !selectedLifestyle.isEmpty {
                roomLayoutGuideSection
            }

            imageUploadSection(title: "내 방 사진 업로드")
            textInputSection(
                title: "한 줄 후기",
                placeholder: selectedLifestyle.isEmpty ? "오늘 나는 ____을 위한 공간을 만들었다." : "오늘 나는 \(selectedLifestyle)을 위한 공간을 만들었다."
            )
            completeButton(point: 100, condition: !selectedLifestyle.isEmpty && selectedImageData != nil && !reviewText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, disabledMessage: "라이프스타일 선택, 내 방 사진 업로드, 한 줄 후기가 모두 필요해요.")

        case "청년월세 지원정책":
            stepLinkSection(title: "Step 1. 청년월세 지원정책 확인하기", buttonTitle: "정책 링크로 이동하고 기본 포인트 받기", urlString: "https://www.bokjiro.go.kr", point: 30)

            Divider()

            Text("Step 2. 실제 참여 인증하기")
                .font(.headline)
                .foregroundColor(Re20sColor.ink)

            imageUploadSection(title: "참여 인증 사진 업로드")
            textInputSection(title: "후기 작성", placeholder: "정책을 확인하거나 신청하면서 느낀 점을 적어주세요.")
            completeButton(point: 150, condition: selectedImageData != nil && !reviewText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, disabledMessage: "선택 인증은 사진과 후기를 모두 입력해야 해요.")

        case "수원시 문화센터 연계":
            stepLinkSection(title: "Step 1. 문화센터 프로그램 확인하기", buttonTitle: "프로그램 링크로 이동하고 기본 포인트 받기", urlString: "https://www.suwon.go.kr", point: 30)

            Divider()

            Text("Step 2. 프로그램 참여 인증하기")
                .font(.headline)
                .foregroundColor(Re20sColor.ink)

            imageUploadSection(title: "참여 인증 사진 업로드")
            textInputSection(title: "후기 작성", placeholder: "프로그램 참여 후기를 적어주세요.")
            completeButton(point: 150, condition: selectedImageData != nil && !reviewText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, disabledMessage: "선택 인증은 사진과 후기를 모두 입력해야 해요.")

        case "건강한 취향 기록 챌린지":
            imageUploadSection(title: "내가 좋아하는 것 사진 업로드")
            textInputSection(title: "취향 기록", placeholder: "유행과 상관없이 내가 좋아하는 이유를 적어주세요.")
            completeButton(point: 100, condition: selectedImageData != nil && !reviewText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, disabledMessage: "사진과 글 기록을 모두 입력해야 해요.")

        default:
            Text("미션 인증 화면")
                .foregroundColor(Re20sColor.subText)
        }
    }

    private var meditationTimerSection: some View {
        Re20sGlassCard {
            VStack(alignment: .leading, spacing: 14) {
                Text("5분 명상 타이머")
                    .font(.headline)
                    .foregroundColor(Re20sColor.ink)

                Text(timeText(timerSeconds))
                    .font(.system(size: 42, weight: .heavy))
                    .foregroundColor(Re20sColor.deepSage)
                    .frame(maxWidth: .infinity)

                HStack {
                    Button {
                        isTimerRunning = true
                    } label: {
                        Text("시작")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Re20sColor.sage)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                    }

                    Button {
                        isTimerRunning = false
                        timerSeconds = 300
                        isTimerCompleted = false
                    } label: {
                        Text("초기화")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white.opacity(0.6))
                            .foregroundColor(Re20sColor.subText)
                            .cornerRadius(16)
                    }
                }

                if isTimerCompleted {
                    Text("타이머 완료!")
                        .fontWeight(.semibold)
                        .foregroundColor(Re20sColor.sage)
                }
            }
        }
    }

    private var moodSection: some View {
        Re20sGlassCard {
            VStack(alignment: .leading, spacing: 12) {
                Text("오늘 기분 선택")
                    .font(.headline)
                    .foregroundColor(Re20sColor.ink)

                HStack {
                    ForEach(moods, id: \.self) { mood in
                        Button {
                            selectedMood = mood
                        } label: {
                            Text(mood)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 12)
                                .background(selectedMood == mood ? Re20sColor.sage.opacity(0.2) : Color.white.opacity(0.55))
                                .foregroundColor(selectedMood == mood ? Re20sColor.deepSage : Re20sColor.subText)
                                .cornerRadius(14)
                        }
                    }
                }
            }
        }
    }

    private var restSelectSection: some View {
        Re20sGlassCard {
            VStack(alignment: .leading, spacing: 12) {
                Text("오늘 한 휴식 선택")
                    .font(.headline)
                    .foregroundColor(Re20sColor.ink)

                ForEach(restOptions, id: \.self) { rest in
                    Button {
                        selectedRest = rest
                    } label: {
                        HStack {
                            Text(rest)
                            Spacer()

                            if selectedRest == rest {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Re20sColor.sage)
                            }
                        }
                        .padding()
                        .background(selectedRest == rest ? Re20sColor.sage.opacity(0.15) : Color.white.opacity(0.55))
                        .foregroundColor(Re20sColor.ink)
                        .cornerRadius(14)
                    }
                }
            }
        }
    }

    private var lifestyleSelectSection: some View {
        Re20sGlassCard {
            VStack(alignment: .leading, spacing: 12) {
                Text("오늘 내 방에서 하고 싶은 핵심 활동 선택")
                    .font(.headline)
                    .foregroundColor(Re20sColor.ink)

                ForEach(lifestyleOptions, id: \.self) { lifestyle in
                    Button {
                        selectedLifestyle = lifestyle
                    } label: {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(lifestyle)
                                    .font(.body)
                                    .fontWeight(.semibold)

                                Text(lifestyleShortGuide(for: lifestyle))
                                    .font(.caption)
                                    .foregroundColor(Re20sColor.subText)
                            }

                            Spacer()

                            if selectedLifestyle == lifestyle {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Re20sColor.sage)
                            }
                        }
                        .padding()
                        .background(selectedLifestyle == lifestyle ? Re20sColor.sage.opacity(0.15) : Color.white.opacity(0.55))
                        .foregroundColor(Re20sColor.ink)
                        .cornerRadius(14)
                    }
                }
            }
        }
    }

    private var roomLayoutGuideSection: some View {
        Re20sGlassCard {
            VStack(alignment: .leading, spacing: 16) {
                Text("추천 공간 배치 가이드")
                    .font(.headline)
                    .foregroundColor(Re20sColor.ink)

                Text(roomGuideTitle(for: selectedLifestyle))
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Re20sColor.deepSage)

                Text(roomGuideDescription(for: selectedLifestyle))
                    .font(.subheadline)
                    .foregroundColor(Re20sColor.subText)
                    .fixedSize(horizontal: false, vertical: true)

                RoomLayoutDiagramView(lifestyle: selectedLifestyle)

                Text("가이드를 참고해서 내 방을 정리하거나, 앞으로 이렇게 꾸미겠다는 포부를 담아 인증해보세요.")
                    .font(.caption)
                    .foregroundColor(Re20sColor.subText)
            }
        }
    }

    private func imageUploadSection(title: String) -> some View {
        Re20sGlassCard {
            VStack(alignment: .leading, spacing: 12) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(Re20sColor.ink)

                PhotosPicker(selection: $selectedPhotoItem, matching: .images) {
                    HStack {
                        Image(systemName: "photo")
                        Text(selectedImageData == nil ? "이미지 업로드하기" : "이미지 업로드 완료")

                        Spacer()

                        if selectedImageData != nil {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Re20sColor.sage)
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.55))
                    .foregroundColor(Re20sColor.ink)
                    .cornerRadius(14)
                }
            }
        }
    }

    private func textInputSection(title: String, placeholder: String) -> some View {
        Re20sGlassCard {
            VStack(alignment: .leading, spacing: 12) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(Re20sColor.ink)

                TextField(placeholder, text: $reviewText, axis: .vertical)
                    .lineLimit(3...5)
                    .padding()
                    .background(Color.white.opacity(0.55))
                    .cornerRadius(14)
            }
        }
    }

    private func stepLinkSection(title: String, buttonTitle: String, urlString: String, point: Int) -> some View {
        Re20sGlassCard {
            VStack(alignment: .leading, spacing: 12) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(Re20sColor.ink)

                Button {
                    openExternalLink(urlString)

                    if !hasReceivedBasicPoint {
                        appState.addCorePoint(point)
                        appState.addMissionRecord(
                            title: "\(solution.title) 기본 참여",
                            point: point,
                            review: "외부 링크를 확인했어요."
                        )
                        earnedPoint += point
                        hasReceivedBasicPoint = true
                        hasClickedExternalLink = true
                    }
                } label: {
                    HStack {
                        Text(hasReceivedBasicPoint ? "기본 포인트 적립 완료 +\(point) CORE" : buttonTitle)
                        Spacer()
                        Image(systemName: "arrow.up.right.square")
                    }
                    .padding()
                    .background(Re20sColor.sage)
                    .foregroundColor(.white)
                    .cornerRadius(16)
                }

                if hasClickedExternalLink {
                    Text("기본 포인트가 마이페이지와 기록에 적립됐어요.")
                        .font(.caption)
                        .foregroundColor(Re20sColor.sage)
                }
            }
        }
    }

    private func completeButton(point: Int, condition: Bool, disabledMessage: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Button {
                guard condition else { return }

                if !hasCompletedMission {
                    appState.addCorePoint(point)
                    appState.addMissionRecord(
                        title: solution.title,
                        point: point,
                        review: reviewText
                    )
                    earnedPoint += point
                    hasCompletedMission = true
                }
            } label: {
                Text(hasCompletedMission ? "미션 완료됨 +\(point) CORE" : "인증 완료하고 포인트 받기")
                    .font(.system(size: 15, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(condition ? Re20sColor.sage : Color.gray.opacity(0.45))
                    .foregroundColor(.white)
                    .cornerRadius(18)
            }
            .disabled(!condition || hasCompletedMission)

            if !condition {
                Text(disabledMessage)
                    .font(.caption)
                    .foregroundColor(Re20sColor.subText)
            }
        }
    }

    private var completionBox: some View {
        Re20sGlassCard {
            VStack(alignment: .leading, spacing: 12) {
                Text("포인트 적립 완료!")
                    .font(.headline)
                    .foregroundColor(Re20sColor.deepSage)

                Text("+\(earnedPoint) CORE 포인트가 적립됐어요.")
                    .font(.subheadline)
                    .foregroundColor(Re20sColor.ink)

                NavigationLink {
                    MyPageView()
                        .environmentObject(appState)
                } label: {
                    Text("마이페이지에서 마일리지 확인하기")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Re20sColor.sage.opacity(0.16))
                        .foregroundColor(Re20sColor.deepSage)
                        .cornerRadius(16)
                }
            }
        }
    }

    private func timeText(_ seconds: Int) -> String {
        let minute = seconds / 60
        let second = seconds % 60
        return String(format: "%02d:%02d", minute, second)
    }

    private func openExternalLink(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }

    private func lifestyleShortGuide(for lifestyle: String) -> String {
        switch lifestyle {
        case "홈트/운동":
            return "중앙 공간과 동선을 확보해요."
        case "요리/홈쿡":
            return "주방과 침대 사이를 분리하고 환기 동선을 만들어요."
        case "휴식/넷플릭스":
            return "스크린이 잘 보이는 아늑한 배치를 만들어요."
        case "재택근무/공부":
            return "침대가 시야에서 분리되는 집중형 배치를 만들어요."
        default:
            return ""
        }
    }

    private func roomGuideTitle(for lifestyle: String) -> String {
        switch lifestyle {
        case "홈트/운동":
            return "중앙 공간 확보형 배치"
        case "요리/홈쿡":
            return "주방 분리·환기형 배치"
        case "휴식/넷플릭스":
            return "아늑한 시청형 배치"
        case "재택근무/공부":
            return "집중형 업무·공부 배치"
        default:
            return "맞춤형 공간 배치"
        }
    }

    private func roomGuideDescription(for lifestyle: String) -> String {
        switch lifestyle {
        case "홈트/운동":
            return "원룸 중앙 공간을 최대한 비우고, 접이식 매트나 운동 도구를 꺼내기 쉬운 위치에 배치해요. 침대와 책상 사이 동선을 막지 않는 것이 핵심이에요."
        case "요리/홈쿡":
            return "주방과 침대 사이에 파티션이나 수납장을 두어 생활 영역을 분리해요. 창문이나 환풍기 방향으로 냄새가 빠질 수 있도록 환기 경로를 확보해요."
        case "휴식/넷플릭스":
            return "침대나 소파에서 화면이 잘 보이도록 스크린 방향을 조정해요. 조명은 눈부시지 않게 낮추고, 자주 쓰는 물건은 손이 닿는 곳에 모아둬요."
        case "재택근무/공부":
            return "책상에 앉았을 때 침대가 정면 시야에 들어오지 않도록 배치해요. 침대는 등 뒤나 측면으로 두고, 책상 주변에는 공부·업무 물건만 남겨 집중감을 높여요."
        default:
            return ""
        }
    }
}

// MARK: - 원룸 배치도

struct RoomLayoutDiagramView: View {
    let lifestyle: String

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.white.opacity(0.7))
                    .frame(height: 240)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Re20sColor.sage.opacity(0.3), lineWidth: 2)
                    )

                VStack(spacing: 12) {
                    HStack(spacing: 12) {
                        roomBlock(title: "침대", icon: "bed.double.fill")

                        if lifestyle == "요리/홈쿡" {
                            roomBlock(title: "파티션", icon: "rectangle.split.2x1.fill")
                        } else if lifestyle == "재택근무/공부" {
                            roomBlock(title: "시야 분리", icon: "eye.slash.fill")
                        } else {
                            roomBlock(title: "수납", icon: "archivebox.fill")
                        }
                    }

                    HStack(spacing: 12) {
                        if lifestyle == "홈트/운동" {
                            roomBlock(title: "운동 매트", icon: "figure.walk", isHighlight: true)
                        } else if lifestyle == "휴식/넷플릭스" {
                            roomBlock(title: "스크린", icon: "tv.fill", isHighlight: true)
                        } else {
                            roomBlock(title: "중앙 동선", icon: "arrow.left.and.right", isHighlight: true)
                        }

                        roomBlock(title: "책상", icon: "desktopcomputer")
                    }

                    HStack(spacing: 12) {
                        roomBlock(title: "주방", icon: "fork.knife")

                        if lifestyle == "요리/홈쿡" {
                            roomBlock(title: "환기 경로", icon: "wind", isHighlight: true)
                        } else if lifestyle == "재택근무/공부" {
                            roomBlock(title: "집중 책상", icon: "book.fill", isHighlight: true)
                        } else if lifestyle == "휴식/넷플릭스" {
                            roomBlock(title: "아늑한 조명", icon: "lightbulb.fill", isHighlight: true)
                        } else {
                            roomBlock(title: "비운 공간", icon: "square.dashed", isHighlight: true)
                        }
                    }
                }
                .padding()
            }

            Text("가상 원룸 배치도")
                .font(.caption)
                .foregroundColor(Re20sColor.subText)
        }
    }

    private func roomBlock(title: String, icon: String, isHighlight: Bool = false) -> some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.title3)

            Text(title)
                .font(.caption)
                .fontWeight(.semibold)
        }
        .foregroundColor(isHighlight ? Re20sColor.deepSage : Re20sColor.ink)
        .frame(maxWidth: .infinity)
        .frame(height: 58)
        .background(isHighlight ? Re20sColor.sage.opacity(0.18) : Color.white.opacity(0.55))
        .cornerRadius(12)
    }
}

// MARK: - 커뮤니티 메인

struct CommunityContentView: View {
    let myCoreType: CoreType?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                NavigationLink {
                    ReviewCommunityView()
                } label: {
                    CommunityRow(title: "후기 커뮤니티", subtitle: "8가지 솔루션 후기를 확인해보세요.")
                }

                NavigationLink {
                    DailyChatRoomView()
                } label: {
                    CommunityRow(title: "소통방", subtitle: "자유롭게 일상을 나눠요.")
                }

                if let myCoreType {
                    NavigationLink {
                        SameTypeRoomView(coreType: myCoreType)
                    } label: {
                        CommunityRow(title: "My Type 소통방", subtitle: "\(myCoreType.name)끼리 소통하는 방")
                    }
                } else {
                    NavigationLink {
                        DiagnosisView()
                    } label: {
                        CommunityRow(title: "My Type 소통방", subtitle: "테스트 후 같은 유형방에 입장할 수 있어요.")
                    }
                }

                Spacer(minLength: 80)
            }
            .padding(.bottom, 20)
        }
    }
}

struct CommunityRow: View {
    let title: String
    let subtitle: String

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(Re20sColor.ink)

                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(Re20sColor.subText)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(Re20sColor.sage)
        }
        .padding()
        .background(Color.white.opacity(0.55))
        .cornerRadius(18)
    }
}

// MARK: - 후기 커뮤니티

struct ReviewPost: Identifiable {
    let id = UUID()
    let solution: SolutionItem
    let userName: String
    let content: String
}

struct ReviewCommunityView: View {
    private var reviews: [ReviewPost] {
        [
            ReviewPost(solution: allSolutionItems[0], userName: "초록하루", content: "SNS를 안 보는 시간이 생기니까 생각보다 마음이 편해졌어요."),
            ReviewPost(solution: allSolutionItems[1], userName: "느린기록", content: "작은 일도 사진으로 남기니까 내가 아무것도 안 한 사람은 아니라는 느낌이 들었어요."),
            ReviewPost(solution: allSolutionItems[2], userName: "숨고르기", content: "하루 5분 호흡만 했는데도 잠들기 전에 머리가 덜 복잡했어요."),
            ReviewPost(solution: allSolutionItems[3], userName: "쉼표", content: "쉬는 걸 미션으로 생각하니까 오히려 죄책감 없이 쉴 수 있었어요."),
            ReviewPost(solution: allSolutionItems[4], userName: "작은방", content: "재택근무형 배치 가이드를 보고 책상을 침대와 분리했더니 집중이 훨씬 잘 됐어요."),
            ReviewPost(solution: allSolutionItems[5], userName: "월세탈출", content: "지원 조건을 확인해보니까 신청할 수 있는 항목이 있어서 바로 메모해뒀어요."),
            ReviewPost(solution: allSolutionItems[6], userName: "문화산책", content: "혼자 할 수 있는 프로그램이 있어서 부담 없이 신청해보고 싶어졌어요."),
            ReviewPost(solution: allSolutionItems[7], userName: "내취향", content: "남들이 하는 걸 따라가기보다 내가 좋아하는 걸 정하니까 훨씬 가벼웠어요.")
        ]
    }

    var body: some View {
        ZStack {
            Re20sBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(reviews) { review in
                        NavigationLink {
                            SolutionExplanationView(solution: review.solution)
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(review.solution.title)
                                        .font(.headline)
                                        .foregroundColor(Re20sColor.deepSage)

                                    Text(review.content)
                                        .font(.body)
                                        .foregroundColor(Re20sColor.ink)

                                    Text("작성자: \(review.userName)")
                                        .font(.caption)
                                        .foregroundColor(Re20sColor.subText)
                                }

                                Spacer()

                                Image(systemName: "chevron.right")
                                    .foregroundColor(Re20sColor.sage)
                            }
                            .padding()
                            .background(Color.white.opacity(0.55))
                            .cornerRadius(18)
                        }
                    }
                }
                .padding(24)
            }
        }
        .navigationTitle("후기 커뮤니티")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - 채팅 공통

struct ChatMessage: Identifiable {
    let id = UUID()
    let userName: String
    let message: String
}

struct ChatBubble: View {
    let userName: String
    let message: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(userName)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(Re20sColor.deepSage)

            Text(message)
                .font(.body)
                .foregroundColor(Re20sColor.ink)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.55))
        .cornerRadius(16)
    }
}

struct ChatInputBar: View {
    @Binding var inputText: String
    let sendAction: () -> Void

    var body: some View {
        HStack(spacing: 10) {
            TextField("메시지를 입력하세요", text: $inputText, axis: .vertical)
                .lineLimit(1...3)
                .textFieldStyle(.plain)
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(Re20sColor.ink)
                .padding(.vertical, 12)
                .padding(.horizontal, 14)
                .background(Color.white.opacity(0.72))
                .cornerRadius(18)

            Button {
                sendAction()
            } label: {
                Image(systemName: "paperplane.fill")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 46, height: 46)
                    .background(
                        inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                        ? Color.gray.opacity(0.45)
                        : Re20sColor.sage
                    )
                    .clipShape(Circle())
            }
            .disabled(inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 26)
                .fill(Color.white.opacity(0.72))
                .overlay(
                    RoundedRectangle(cornerRadius: 26)
                        .stroke(Color.white.opacity(0.85), lineWidth: 1)
                )
                .shadow(color: Re20sColor.sage.opacity(0.16), radius: 16, x: 0, y: 8)
        )
    }
}

// MARK: - 소통방

struct DailyChatRoomView: View {
    @State private var inputText: String = ""

    @State private var messages: [ChatMessage] = [
        ChatMessage(userName: "오늘도천천히", message: "다들 오늘 하루 어땠어요? 저는 산책하고 왔어요."),
        ChatMessage(userName: "수원이친구", message: "저는 과제하다가 잠깐 쉬는 중이에요."),
        ChatMessage(userName: "마음정리", message: "요즘 너무 바빴는데 여기 들어오니까 조금 안정되는 느낌이에요."),
        ChatMessage(userName: "초록불빛", message: "저녁 먹고 디지털 디톡스 해보려고요.")
    ]

    var body: some View {
        ZStack {
            Re20sBackground()

            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(messages) { chat in
                            ChatBubble(userName: chat.userName, message: chat.message)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                    .padding(.bottom, 120)
                }

                ChatInputBar(inputText: $inputText) {
                    sendMessage()
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 96)
            }
        }
        .navigationTitle("소통방")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func sendMessage() {
        let trimmedText = inputText.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedText.isEmpty else { return }

        messages.append(
            ChatMessage(userName: "나", message: trimmedText)
        )

        inputText = ""
    }
}

// MARK: - 같은 유형방

struct SameTypeRoomView: View {
    let coreType: CoreType

    @State private var inputText: String = ""
    @State private var messages: [ChatMessage] = []

    var body: some View {
        ZStack {
            Re20sBackground()

            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("\(coreType.name) Room")
                        .font(.system(size: 26, weight: .heavy))
                        .foregroundColor(Re20sColor.deepSage)

                    Text("같은 유형의 사람들끼리 고민과 실천 경험을 나누는 공간입니다.")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(Re20sColor.subText)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 24)

                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(messages) { chat in
                            ChatBubble(userName: chat.userName, message: chat.message)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                    .padding(.bottom, 120)
                }

                ChatInputBar(inputText: $inputText) {
                    sendMessage()
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 96)
            }
        }
        .navigationTitle("My Type 소통방")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if messages.isEmpty {
                messages = defaultMessages(for: coreType)
            }
        }
    }

    private func sendMessage() {
        let trimmedText = inputText.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedText.isEmpty else { return }

        messages.append(
            ChatMessage(userName: "나", message: trimmedText)
        )

        inputText = ""
    }

    private func defaultMessages(for type: CoreType) -> [ChatMessage] {
        switch type {
        case .comparison:
            return [
                ChatMessage(userName: "비교멈춤", message: "SNS 안 보고 있는 시간 만들기 같이 해볼 사람 있나요?"),
                ChatMessage(userName: "나의속도", message: "저는 오늘 남이 아니라 제 할 일 하나에만 집중해보려고요."),
                ChatMessage(userName: "천천히가자", message: "작은 성취도 기록하니까 조금 덜 불안했어요.")
            ]

        case .overload:
            return [
                ChatMessage(userName: "숨고르기", message: "오늘은 알림 끄고 10분 쉬어봤어요."),
                ChatMessage(userName: "멈춤연습", message: "아무것도 안 하는 시간이 아직 어색한데 조금씩 해보려고요."),
                ChatMessage(userName: "회복중", message: "휴식도 계획에 넣으니까 덜 죄책감 들어요.")
            ]

        case .room:
            return [
                ChatMessage(userName: "작은방", message: "방 한쪽에 작은 조명 하나 뒀는데 분위기가 훨씬 나아졌어요."),
                ChatMessage(userName: "월세고민", message: "청년월세 지원정책 조건 같이 확인해보면 좋을 것 같아요."),
                ChatMessage(userName: "내공간", message: "좁아도 내 공간이라는 느낌이 중요하더라고요.")
            ]

        case .ethos:
            return [
                ChatMessage(userName: "내취향", message: "요즘 유행보다 내가 진짜 좋아하는 걸 찾아보는 중이에요."),
                ChatMessage(userName: "건강루틴", message: "오운완 인증보다 몸에 무리 안 가는 루틴으로 바꿨어요."),
                ChatMessage(userName: "문화산책", message: "문화센터 강좌 찾아보니까 생각보다 재밌는 게 많네요.")
            ]
        }
    }
}

#Preview {
    SolutionView()
        .environmentObject(AppState())
}
