import SwiftUI

enum EmotionState: String, CaseIterable, Identifiable {
    case passion = "열정"
    case happiness = "행복"
    case burnout = "방전"
    case anxiety = "불안"
    case boredom = "지루"
    case calm = "평온"

    var id: String { rawValue }

    var color: Color {
        switch self {
        case .passion:
            // 열정: 과하지 않은 코랄 오렌지
            return Color(red: 0.93, green: 0.50, blue: 0.34)

        case .happiness:
            // 행복: 따뜻한 크림 옐로우
            return Color(red: 0.95, green: 0.72, blue: 0.32)

        case .burnout:
            // 방전: 차분한 웜 그레이
            return Color(red: 0.55, green: 0.57, blue: 0.55)

        case .anxiety:
            // 불안: 너무 강하지 않은 더스티 로즈
            return Color(red: 0.78, green: 0.42, blue: 0.43)

        case .boredom:
            // 지루: 노랑 대신 톤다운 라벤더
            return Color(red: 0.60, green: 0.55, blue: 0.76)

        case .calm:
            // 평온: 기존 앱 메인 세이지 그린
            return Re20sColor.sage
        }
    }

    var icon: String {
        switch self {
        case .passion:
            return "flame.fill"
        case .happiness:
            return "sun.max.fill"
        case .burnout:
            return "battery.25"
        case .anxiety:
            return "exclamationmark.triangle.fill"
        case .boredom:
            return "zzz"
        case .calm:
            return "leaf.fill"
        }
    }
}

struct RecordView: View {
    @EnvironmentObject var appState: AppState
    @State private var showCalendar: Bool = false

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Re20sBackground()

                ScrollView {
                    VStack(alignment: .leading, spacing: 28) {
                        headerSection

                        emotionRecordSection

                        if showCalendar {
                            CalendarEmotionView()
                                .environmentObject(appState)
                        }

                        missionReviewSection

                        Spacer(minLength: 120)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 28)
                    .padding(.bottom, 30)
                }
            }
            .navigationBarHidden(true)
        }
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("기록")
                .font(.system(size: 30, weight: .heavy))
                .foregroundColor(Re20sColor.ink)

            Text("감정과 미션을 쌓아 나의 패턴을 확인해요.")
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(Re20sColor.subText)
        }
    }

    private var emotionRecordSection: some View {
        Re20sGlassCard {
            VStack(alignment: .leading, spacing: 18) {
                Re20sSectionTitle(
                    "오늘의 감정 일기",
                    subtitle: "오늘 나의 상태와 가장 가까운 감정을 선택해보세요."
                )

                LazyVGrid(columns: columns, spacing: 18) {
                    ForEach(EmotionState.allCases) { emotion in
                        Button {
                            appState.saveTodayEmotion(emotion.rawValue)

                            withAnimation(.spring(response: 0.35, dampingFraction: 0.82)) {
                                showCalendar = true
                            }
                        } label: {
                            VStack(spacing: 8) {
                                ZStack {
                                    Circle()
                                        .fill(emotion.color.opacity(0.18))
                                        .frame(width: 72, height: 72)

                                    Image(systemName: emotion.icon)
                                        .font(.title2)
                                        .foregroundColor(emotion.color)
                                }

                                Text(emotion.rawValue)
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Re20sColor.ink)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                }

                if !showCalendar {
                    Text("감정을 선택하면 캘린더 기록으로 전환돼요.")
                        .font(.caption)
                        .foregroundColor(Re20sColor.subText)
                }
            }
        }
    }

    private var missionReviewSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Re20sSectionTitle("최근 미션 후기")

            if appState.missionRecords.isEmpty {
                Re20sGlassCard {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("진행한 기록이 없어요!")
                            .font(.system(size: 20, weight: .heavy))
                            .foregroundColor(Re20sColor.ink)

                        Text("솔루션 창에서 미션을 수행하면 이곳에서 기록을 확인할 수 있어요.")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(Re20sColor.subText)

                        NavigationLink {
                            SolutionView()
                                .environmentObject(appState)
                        } label: {
                            Text("솔루션 창으로 이동")
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
            } else {
                VStack(spacing: 12) {
                    ForEach(appState.missionRecords) { record in
                        MissionRecordCard(record: record)
                            .environmentObject(appState)
                    }
                }
            }
        }
    }
}

struct CalendarEmotionView: View {
    @EnvironmentObject var appState: AppState

    private let calendar = Calendar.current
    private let weekDays = ["일", "월", "화", "수", "목", "금", "토"]
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)

    private var currentMonthText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월"
        return formatter.string(from: Date())
    }

    private var daysInMonth: [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: Date()),
              let dayRange = calendar.range(of: .day, in: .month, for: Date()) else {
            return []
        }

        return dayRange.compactMap { day in
            calendar.date(byAdding: .day, value: day - 1, to: monthInterval.start)
        }
    }

    private var firstWeekdayOffset: Int {
        guard let firstDay = daysInMonth.first else { return 0 }
        return calendar.component(.weekday, from: firstDay) - 1
    }

    var body: some View {
        Re20sGlassCard {
            VStack(alignment: .leading, spacing: 16) {
                Text("감정 캘린더")
                    .font(.system(size: 22, weight: .heavy))
                    .foregroundColor(Re20sColor.ink)

                Text(currentMonthText)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Re20sColor.deepSage)

                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(weekDays, id: \.self) { day in
                        Text(day)
                            .font(.caption)
                            .foregroundColor(Re20sColor.subText)
                            .frame(height: 24)
                    }

                    ForEach(0..<firstWeekdayOffset, id: \.self) { _ in
                        Color.clear
                            .frame(height: 38)
                    }

                    ForEach(daysInMonth, id: \.self) { date in
                        let key = dateKey(date)
                        let emotion = appState.emotionRecords[key]

                        Text("\(calendar.component(.day, from: date))")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(emotion == nil ? Re20sColor.subText : .white)
                            .frame(width: 38, height: 38)
                            .background(emotionColor(emotion))
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(isToday(date) ? Re20sColor.deepSage : Color.clear, lineWidth: 2)
                            )
                    }
                }

                emotionLegend
            }
        }
    }

    private var emotionLegend: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("감정 색상")
                .font(.caption)
                .foregroundColor(Re20sColor.subText)

            HStack(spacing: 10) {
                ForEach(EmotionState.allCases) { emotion in
                    HStack(spacing: 4) {
                        Circle()
                            .fill(emotion.color)
                            .frame(width: 10, height: 10)

                        Text(emotion.rawValue)
                            .font(.caption2)
                            .foregroundColor(Re20sColor.subText)
                    }
                }
            }
        }
    }

    private func emotionColor(_ emotion: String?) -> Color {
        guard let emotion else {
            return Color.white.opacity(0.55)
        }

        return EmotionState.allCases.first { $0.rawValue == emotion }?.color ?? Color.gray
    }

    private func isToday(_ date: Date) -> Bool {
        calendar.isDateInToday(date)
    }

    private func dateKey(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}

struct MissionRecordCard: View {
    @EnvironmentObject var appState: AppState
    let record: MissionRecord

    var body: some View {
        Re20sGlassCard {
            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(record.title)
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(Re20sColor.ink)

                        Text(dateText(record.date))
                            .font(.caption)
                            .foregroundColor(Re20sColor.subText)
                    }

                    Spacer()

                    Text("+\(record.point) CORE")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(Re20sColor.deepSage)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 10)
                        .background(Re20sColor.sage.opacity(0.14))
                        .cornerRadius(10)
                }

                if record.review.isEmpty {
                    Text("아직 후기가 없어요.")
                        .font(.subheadline)
                        .foregroundColor(Re20sColor.subText)
                } else {
                    Text(record.review)
                        .font(.subheadline)
                        .foregroundColor(Re20sColor.ink)
                }

                NavigationLink {
                    MissionReviewWriteView(recordID: record.id)
                        .environmentObject(appState)
                } label: {
                    Text(record.review.isEmpty ? "후기 작성하기" : "후기 수정하기")
                        .font(.system(size: 15, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Re20sColor.sage.opacity(0.16))
                        .foregroundColor(Re20sColor.deepSage)
                        .cornerRadius(16)
                }
            }
        }
    }

    private func dateText(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }
}

struct MissionReviewWriteView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) private var dismiss

    let recordID: UUID

    @State private var reviewText: String = ""

    private var record: MissionRecord? {
        appState.missionRecords.first { $0.id == recordID }
    }

    private var canSave: Bool {
        !reviewText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        ZStack {
            Re20sBackground()

            VStack(alignment: .leading, spacing: 20) {
                Re20sSectionTitle(
                    record?.title ?? "미션 후기",
                    subtitle: "미션을 수행하면서 느낀 점을 적어주세요."
                )

                TextField("후기를 입력하세요", text: $reviewText, axis: .vertical)
                    .lineLimit(5...8)
                    .padding()
                    .background(Color.white.opacity(0.6))
                    .cornerRadius(18)

                Button {
                    appState.updateMissionReview(recordID: recordID, review: reviewText)
                    dismiss()
                } label: {
                    Text("후기 저장하기")
                        .font(.system(size: 15, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(canSave ? Re20sColor.sage : Color.gray.opacity(0.45))
                        .foregroundColor(.white)
                        .cornerRadius(18)
                }
                .disabled(!canSave)

                Spacer()
            }
            .padding(24)
        }
        .navigationTitle("후기 작성")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            reviewText = record?.review ?? ""
        }
    }
}

#Preview {
    RecordView()
        .environmentObject(AppState())
}
