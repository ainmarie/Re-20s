import Foundation

struct MissionRecord: Identifiable {
    let id = UUID()
    let title: String
    let date: Date
    let point: Int
    var review: String
}

final class AppState: ObservableObject {
    @Published var hasSeenOpening: Bool = false
    @Published var isSignedUp: Bool = false

    @Published var nickname: String = ""
    @Published var name: String = ""
    @Published var genderAge: String = ""
    @Published var currentStatus: String = ""

    @Published var hasDiagnosisResult: Bool = false
    @Published var diagnosisResultType: String = ""

    @Published var diagnosisScores: [CoreType: Int] = [
        .comparison: 0,
        .overload: 0,
        .room: 0,
        .ethos: 0
    ]

    @Published var diagnosisPercentages: [CoreType: Double] = [
        .comparison: 0,
        .overload: 0,
        .room: 0,
        .ethos: 0
    ]

    @Published var corePoint: Int = 1500

    @Published var emotionRecords: [String: String] = [:]
    @Published var missionRecords: [MissionRecord] = []

    init() {
        makeSampleEmotionRecords()
    }

    func saveDiagnosisResult(_ result: DiagnosisResult) {
        hasDiagnosisResult = true
        diagnosisResultType = result.winnerType.name
        diagnosisScores = result.scores
        diagnosisPercentages = result.percentages
    }

    func addCorePoint(_ point: Int) {
        corePoint += point
    }

    func saveTodayEmotion(_ emotion: String) {
        let key = dateKey(Date())
        emotionRecords[key] = emotion
    }

    func addMissionRecord(title: String, point: Int, review: String = "") {
        let newRecord = MissionRecord(
            title: title,
            date: Date(),
            point: point,
            review: review
        )

        missionRecords.insert(newRecord, at: 0)
    }

    func updateMissionReview(recordID: UUID, review: String) {
        if let index = missionRecords.firstIndex(where: { $0.id == recordID }) {
            missionRecords[index].review = review
        }
    }

    private func makeSampleEmotionRecords() {
        let samples: [(Int, String)] = [
            (-1, "평온"),
            (-2, "방전"),
            (-3, "열정"),
            (-5, "불안"),
            (-7, "지루"),
            (-9, "평온"),
            (-12, "열정"),
            (-15, "방전")
        ]

        for sample in samples {
            if let date = Calendar.current.date(byAdding: .day, value: sample.0, to: Date()) {
                emotionRecords[dateKey(date)] = sample.1
            }
        }
    }

    private func dateKey(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}
