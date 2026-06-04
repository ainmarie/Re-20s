import SwiftUI
import Darwin

struct DiagnosisQuestion: Identifiable {
    let id: Int
    let coreType: CoreType
    let category: String
    let bridgeText: String?
    let text: String
}

struct DiagnosisResult {
    let winnerType: CoreType
    let scores: [CoreType: Int]
    let percentages: [CoreType: Double]
}

struct DiagnosisView: View {
    @EnvironmentObject var appState: AppState

    @State private var currentIndex: Int = 0
    @State private var selectedScore: Int? = nil
    @State private var answers: [Int: Int] = [:]
    @State private var navigateToResult: Bool = false

    private let questions: [DiagnosisQuestion] = [
        DiagnosisQuestion(id: 1, coreType: .room, category: "물리적 영역", bridgeText: nil, text: "집 안에서도 층간소음이나 외부 소리가 들리면 예민해져서 휴식을 망치곤 한다."),
        DiagnosisQuestion(id: 2, coreType: .room, category: "물리적 영역", bridgeText: nil, text: "실내 온도나 습도가 불쾌할 때, 이를 내 컨디션에 맞춰 즉각적이고 완벽하게 조절하는 데 어려움을 겪는다."),
        DiagnosisQuestion(id: 3, coreType: .room, category: "물리적 영역", bridgeText: nil, text: "이 주거공간에서 평생 살 것이 아니라는 생각 때문에 인테리어 등 '가꾸는 즐거움'을 잊고 산다."),
        DiagnosisQuestion(id: 4, coreType: .room, category: "물리적 영역", bridgeText: nil, text: "택배를 받거나 문을 열어줄 때 보안이나 치안 때문에 순간적인 긴장감을 느낀다."),
        DiagnosisQuestion(id: 5, coreType: .room, category: "물리적 영역", bridgeText: nil, text: "내가 원치 않는 시점에 타인에 의해 내 공간의 정적이나 흐름이 깨질 때가 많다."),

        DiagnosisQuestion(id: 6, coreType: .comparison, category: "심리·관계 영역", bridgeText: "좋아요. 이제 시선과 비교에 대한 질문으로 넘어갈게요.", text: "친구의 SNS 게시물을 보고 난 뒤, 내 현실이 갑자기 초라하게 느껴져 앱을 끈 적이 있다."),
        DiagnosisQuestion(id: 7, coreType: .comparison, category: "심리·관계 영역", bridgeText: nil, text: "나보다 잘나가는 사람의 소식을 들으면 축하해주기보다 '나는 지금까지 뭐 했나' 싶다."),
        DiagnosisQuestion(id: 8, coreType: .comparison, category: "심리·관계 영역", bridgeText: nil, text: "내 성취보다 남들이 나를 '성공한 사람'으로 봐주는지가 더 중요하다고 생각한다."),
        DiagnosisQuestion(id: 9, coreType: .comparison, category: "심리·관계 영역", bridgeText: nil, text: "명품이나 유행하는 아이템을 사는 이유 중 하나는 무시당하고 싶지 않기 때문이다."),
        DiagnosisQuestion(id: 10, coreType: .comparison, category: "심리·관계 영역", bridgeText: nil, text: "내가 가진 장점보다는 내가 가지지 못한 것들이 더 크게 눈에 들어온다."),

        DiagnosisQuestion(id: 11, coreType: .overload, category: "시스템적 영역", bridgeText: "숨 가쁘게 달려왔네요. 이번엔 디지털 과부하를 확인해볼게요.", text: "화장실에 갈 때나 밥을 먹을 때 스마트폰이 없으면 허전해서 견딜 수 없다."),
        DiagnosisQuestion(id: 12, coreType: .overload, category: "시스템적 영역", bridgeText: nil, text: "분명히 다른 일을 하려고 폰을 들었는데, 정신 차려보니 쇼츠나 릴스를 30분 넘게 보고 있다."),
        DiagnosisQuestion(id: 13, coreType: .overload, category: "시스템적 영역", bridgeText: nil, text: "종이책이나 긴 칼럼을 읽으려 하면 앞부분만 읽다 금방 집중력이 흐트러진다."),
        DiagnosisQuestion(id: 14, coreType: .overload, category: "시스템적 영역", bridgeText: nil, text: "스마트폰 배터리가 10% 미만으로 떨어지면 비정상적으로 불안함을 느낀다."),
        DiagnosisQuestion(id: 15, coreType: .overload, category: "시스템적 영역", bridgeText: nil, text: "자기 전 스마트폰을 보느라 실제 계획했던 취침 시간보다 1시간 이상 늦게 잔다."),

        DiagnosisQuestion(id: 16, coreType: .ethos, category: "문화적 흐름", bridgeText: "이제 마지막 영역이에요. 내 선택이 정말 나의 선택인지 확인해볼게요.", text: "딱히 필요 없더라도 남들이 다 사는 '대란 아이템'은 일단 사야 마음이 놓인다."),
        DiagnosisQuestion(id: 17, coreType: .ethos, category: "문화적 흐름", bridgeText: nil, text: "내가 진심으로 좋아하는 것보다, 대중적으로 '힙하다'고 평가받는 장소에 가는 편이다."),
        DiagnosisQuestion(id: 18, coreType: .ethos, category: "문화적 흐름", bridgeText: nil, text: "신조어나 최신 유행하는 밈을 모르면 대화에서 소외될까 봐 억지로 찾아본다."),
        DiagnosisQuestion(id: 19, coreType: .ethos, category: "문화적 흐름", bridgeText: nil, text: "인생의 중요한 결정을 할 때 내 행복보다 '남들 보기에 평범한지'가 더 우선이다."),
        DiagnosisQuestion(id: 20, coreType: .ethos, category: "문화적 흐름", bridgeText: nil, text: "가끔은 내가 진짜 무엇을 좋아하는지보다 '무엇을 좋아해야 하는지'를 고민하는 것 같다.")
    ]

    private var currentQuestion: DiagnosisQuestion {
        questions[currentIndex]
    }

    private var progress: Double {
        Double(currentIndex + 1) / Double(questions.count)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Re20sBackground()

                ScrollView {
                    VStack(alignment: .leading, spacing: 26) {
                        headerSection
                        progressSection

                        if let bridgeText = currentQuestion.bridgeText {
                            bridgeCard(bridgeText)
                        }

                        questionCard
                        scoreSection
                        nextButton

                        Spacer(minLength: 80)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 28)
                    .padding(.bottom, 30)
                }

                NavigationLink(
                    destination: DiagnosisResultView()
                        .environmentObject(appState),
                    isActive: $navigateToResult
                ) {
                    EmptyView()
                }
                .hidden()
            }
            .navigationBarHidden(true)
            .onAppear {
                selectedScore = answers[currentQuestion.id]
            }
        }
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("CORE 진단")
                .font(.system(size: 30, weight: .heavy))
                .foregroundColor(Re20sColor.ink)

            Text("나를 힘들게 하는 구조를 가볍게 확인해요.")
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(Re20sColor.subText)
        }
    }

    private var progressSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("\(currentIndex + 1) / \(questions.count)")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Re20sColor.deepSage)

                Spacer()

                Text(currentQuestion.category)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(Re20sColor.subText)
            }

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.white.opacity(0.6))
                        .frame(height: 9)

                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: [Re20sColor.sage, Re20sColor.neoMint],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geometry.size.width * progress, height: 9)
                        .animation(.spring(response: 0.35, dampingFraction: 0.85), value: progress)
                }
            }
            .frame(height: 9)
        }
    }

    private func bridgeCard(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "sparkles")
                .foregroundColor(Re20sColor.sage)

            Text(text)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Re20sColor.deepSage)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(16)
        .background(Re20sColor.sage.opacity(0.12))
        .cornerRadius(20)
    }

    private var questionCard: some View {
        Re20sGlassCard {
            VStack(alignment: .leading, spacing: 18) {
                HStack {
                    Text("Q\(currentQuestion.id)")
                        .font(.system(size: 14, weight: .heavy))
                        .foregroundColor(.white)
                        .padding(.vertical, 7)
                        .padding(.horizontal, 13)
                        .background(Re20sColor.sage)
                        .cornerRadius(16)

                    Spacer()

                    Text(currentQuestion.coreType.rawValue)
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(Re20sColor.deepSage)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                        .background(Re20sColor.sage.opacity(0.12))
                        .cornerRadius(14)
                }

                Text(currentQuestion.text)
                    .font(.system(size: 24, weight: .heavy))
                    .foregroundColor(Re20sColor.ink)
                    .lineSpacing(6)
                    .fixedSize(horizontal: false, vertical: true)

                Text("가장 가까운 정도를 선택해 주세요.")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Re20sColor.subText)
            }
        }
    }

    private var scoreSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("전혀 아니다")
                    .font(.caption)
                    .foregroundColor(Re20sColor.subText)

                Spacer()

                Text("매우 그렇다")
                    .font(.caption)
                    .foregroundColor(Re20sColor.subText)
            }

            HStack(spacing: 10) {
                ForEach(1...5, id: \.self) { score in
                    Button {
                        withAnimation(.spring(response: 0.28, dampingFraction: 0.8)) {
                            selectedScore = score
                            answers[currentQuestion.id] = score
                        }
                    } label: {
                        VStack(spacing: 8) {
                            Text("\(score)")
                                .font(.system(size: 18, weight: .heavy))

                            Circle()
                                .fill(selectedScore == score ? Re20sColor.sage : Color.white.opacity(0.65))
                                .frame(
                                    width: selectedScore == score ? 14 : 8,
                                    height: selectedScore == score ? 14 : 8
                                )
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 74)
                        .background(selectedScore == score ? Re20sColor.sage.opacity(0.16) : Color.white.opacity(0.48))
                        .foregroundColor(selectedScore == score ? Re20sColor.deepSage : Re20sColor.subText)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(selectedScore == score ? Re20sColor.sage.opacity(0.55) : Color.white.opacity(0.6), lineWidth: 1)
                        )
                    }
                }
            }
        }
    }

    private var nextButton: some View {
        Button {
            moveNext()
        } label: {
            Text(currentIndex == questions.count - 1 ? "결과 보기" : "다음")
                .font(.system(size: 16, weight: .bold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 17)
                .background(
                    LinearGradient(
                        colors: selectedScore == nil
                        ? [Color.gray.opacity(0.45), Color.gray.opacity(0.35)]
                        : [Re20sColor.sage, Re20sColor.neoMint],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .foregroundColor(.white)
                .cornerRadius(22)
                .shadow(color: selectedScore == nil ? Color.clear : Re20sColor.sage.opacity(0.22), radius: 14, x: 0, y: 7)
        }
        .disabled(selectedScore == nil)
    }

    private func moveNext() {
        guard let selectedScore else { return }

        answers[currentQuestion.id] = selectedScore

        if currentIndex < questions.count - 1 {
            currentIndex += 1
            self.selectedScore = answers[questions[currentIndex].id]
        } else {
            let result = calculateResult()
            appState.saveDiagnosisResult(result)
            navigateToResult = true
        }
    }

    private func calculateResult() -> DiagnosisResult {
        var scores: [CoreType: Int] = [
            .comparison: 0,
            .overload: 0,
            .room: 0,
            .ethos: 0
        ]

        var fiveCounts: [CoreType: Int] = [
            .comparison: 0,
            .overload: 0,
            .room: 0,
            .ethos: 0
        ]

        var fourCounts: [CoreType: Int] = [
            .comparison: 0,
            .overload: 0,
            .room: 0,
            .ethos: 0
        ]

        for question in questions {
            let answer = answers[question.id] ?? 0
            scores[question.coreType, default: 0] += answer

            if answer == 5 {
                fiveCounts[question.coreType, default: 0] += 1
            }

            if answer == 4 {
                fourCounts[question.coreType, default: 0] += 1
            }
        }

        let maxScore = scores.values.max() ?? 0
        let topTypes = scores.filter { $0.value == maxScore }.map { $0.key }

        let winner = topTypes.sorted {
            let fiveA = fiveCounts[$0, default: 0]
            let fiveB = fiveCounts[$1, default: 0]

            if fiveA != fiveB {
                return fiveA > fiveB
            }

            let fourA = fourCounts[$0, default: 0]
            let fourB = fourCounts[$1, default: 0]

            if fourA != fourB {
                return fourA > fourB
            }

            return $0.rawValue < $1.rawValue
        }.first ?? .comparison

        var percentages: [CoreType: Double] = [:]

        for type in CoreType.allCases {
            percentages[type] = (Double(scores[type, default: 0]) / 25.0) * 100.0
        }

        return DiagnosisResult(
            winnerType: winner,
            scores: scores,
            percentages: percentages
        )
    }
}

// MARK: - 결과 화면

struct DiagnosisResultView: View {
    @EnvironmentObject var appState: AppState

    private var winnerType: CoreType {
        CoreType.allCases.first { $0.name == appState.diagnosisResultType } ?? .comparison
    }

    var body: some View {
        ZStack {
            Re20sBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: 26) {
                    headerSection
                    resultHeroCard
                    scoreBars
                    radarSection
                    solutionButton

                    Spacer(minLength: 100)
                }
                .padding(.horizontal, 24)
                .padding(.top, 28)
                .padding(.bottom, 30)
            }
        }
        .navigationBarHidden(true)
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("진단 결과")
                .font(.system(size: 30, weight: .heavy))
                .foregroundColor(Re20sColor.ink)

            Text("지금 나에게 가장 크게 작용하는 구조를 확인했어요.")
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(Re20sColor.subText)
        }
    }

    private var resultHeroCard: some View {
        Re20sGlassCard {
            VStack(alignment: .leading, spacing: 18) {
                Text("나는")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Re20sColor.subText)

                Text(winnerType.name)
                    .font(.system(size: 34, weight: .heavy))
                    .foregroundColor(Re20sColor.deepSage)

                Text(winnerType.fullName)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(Re20sColor.ink)

                Text(resultCopy(for: winnerType))
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Re20sColor.subText)
                    .lineSpacing(5)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    private var scoreBars: some View {
        Re20sGlassCard {
            VStack(alignment: .leading, spacing: 18) {
                Re20sSectionTitle("CORE 점수", subtitle: "유형별 영향을 백분율로 확인해요.")

                ForEach(CoreType.allCases) { type in
                    let percent = appState.diagnosisPercentages[type] ?? 0

                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(type.rawValue)
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(Re20sColor.ink)

                            Text(type.name)
                                .font(.caption)
                                .foregroundColor(Re20sColor.subText)

                            Spacer()

                            Text("\(Int(percent))%")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(Re20sColor.deepSage)
                        }

                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                Capsule()
                                    .fill(Color.white.opacity(0.65))
                                    .frame(height: 10)

                                Capsule()
                                    .fill(
                                        LinearGradient(
                                            colors: [Re20sColor.sage, Re20sColor.neoMint],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .frame(width: geometry.size.width * CGFloat(percent / 100), height: 10)
                            }
                        }
                        .frame(height: 10)
                    }
                }
            }
        }
    }

    private var radarSection: some View {
        Re20sGlassCard {
            VStack(alignment: .leading, spacing: 18) {
                Re20sSectionTitle("CORE 방사형 그래프", subtitle: "네 영역의 균형을 한눈에 확인해요.")

                CoreRadarChartView(percentages: appState.diagnosisPercentages)
                    .frame(height: 260)
            }
        }
    }

    private var solutionButton: some View {
        NavigationLink {
            SolutionView()
                .environmentObject(appState)
        } label: {
            Text("추천 솔루션 보러가기")
                .font(.system(size: 16, weight: .bold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 17)
                .background(
                    LinearGradient(
                        colors: [Re20sColor.sage, Re20sColor.neoMint],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .foregroundColor(.white)
                .cornerRadius(22)
                .shadow(color: Re20sColor.sage.opacity(0.22), radius: 14, x: 0, y: 7)
        }
    }

    private func resultCopy(for type: CoreType) -> String {
        switch type {
        case .comparison:
            return "타인의 시선과 비교가 내 감정에 크게 영향을 주고 있어요. 남이 아닌 나의 속도를 회복하는 루틴이 필요해요."
        case .overload:
            return "알고리즘, 정보, 일정이 나를 계속 밀어붙이고 있을 수 있어요. 멈추는 연습과 회복 루틴이 필요해요."
        case .room:
            return "내 공간이 충분한 안정감을 주지 못하고 있을 수 있어요. 주거 환경과 생활 동선을 정리하는 솔루션이 도움이 돼요."
        case .ethos:
            return "유행과 분위기에 맞추느라 나의 취향이 흐려지고 있을 수 있어요. 내가 진짜 좋아하는 것을 다시 찾는 시간이 필요해요."
        }
    }
}

// MARK: - 방사형 그래프

struct CoreRadarChartView: View {
    let percentages: [CoreType: Double]

    private let order: [CoreType] = [.comparison, .overload, .room, .ethos]

    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            let radius = size * 0.34

            ZStack {
                ForEach(1...4, id: \.self) { level in
                    RadarPolygon(points: polygonPoints(center: center, radius: radius * CGFloat(level) / 4))
                        .stroke(Color.white.opacity(0.75), lineWidth: 1)
                }

                ForEach(0..<4, id: \.self) { index in
                    Path { path in
                        path.move(to: center)
                        path.addLine(to: vertexPoint(index: index, center: center, radius: radius))
                    }
                    .stroke(Color.white.opacity(0.75), lineWidth: 1)
                }

                RadarPolygon(points: dataPoints(center: center, radius: radius))
                    .fill(Re20sColor.sage.opacity(0.24))

                RadarPolygon(points: dataPoints(center: center, radius: radius))
                    .stroke(Re20sColor.deepSage, lineWidth: 2)

                ForEach(0..<4, id: \.self) { index in
                    let point = dataPoints(center: center, radius: radius)[index]

                    Circle()
                        .fill(Re20sColor.deepSage)
                        .frame(width: 9, height: 9)
                        .position(point)
                }

                ForEach(0..<4, id: \.self) { index in
                    let labelPoint = vertexPoint(index: index, center: center, radius: radius + 28)

                    Text(order[index].rawValue)
                        .font(.system(size: 18, weight: .heavy))
                        .foregroundColor(Re20sColor.deepSage)
                        .frame(width: 34, height: 34)
                        .background(Color.white.opacity(0.72))
                        .clipShape(Circle())
                        .position(labelPoint)
                }
            }
        }
    }

    private func value(for type: CoreType) -> CGFloat {
        CGFloat((percentages[type] ?? 0) / 100.0)
    }

    private func polygonPoints(center: CGPoint, radius: CGFloat) -> [CGPoint] {
        (0..<4).map {
            vertexPoint(index: $0, center: center, radius: radius)
        }
    }

    private func dataPoints(center: CGPoint, radius: CGFloat) -> [CGPoint] {
        order.enumerated().map { index, type in
            vertexPoint(index: index, center: center, radius: radius * value(for: type))
        }
    }

    private func vertexPoint(index: Int, center: CGPoint, radius: CGFloat) -> CGPoint {
        let angle = (-90.0 + Double(index) * 90.0) * Double.pi / 180.0

        return CGPoint(
            x: center.x + CGFloat(Darwin.cos(angle)) * radius,
            y: center.y + CGFloat(Darwin.sin(angle)) * radius
        )
    }
}

struct RadarPolygon: Shape {
    let points: [CGPoint]

    func path(in rect: CGRect) -> Path {
        var path = Path()

        guard let first = points.first else {
            return path
        }

        path.move(to: first)

        for point in points.dropFirst() {
            path.addLine(to: point)
        }

        path.closeSubpath()

        return path
    }
}

#Preview {
    DiagnosisView()
        .environmentObject(AppState())
}
