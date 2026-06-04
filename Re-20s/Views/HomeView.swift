import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState

    private var resultImageName: String {
        switch appState.diagnosisResultType {
        case "타인비교형":
            return "ctypesuwonie"
        case "시스템과로형":
            return "otypesuwonie"
        case "환경압박형":
            return "rtypesuwonie"
        case "트렌드동조형":
            return "etypesuwonie"
        default:
            return "suwonieopening"
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Re20sBackground()

                ScrollView {
                    VStack(alignment: .leading, spacing: 28) {
                        headerSection

                        mainHeroCard

                        diagnosisStatusCard

                        quickMenuSection

                        OperatorInfoView()

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
            Text("안녕, \(appState.nickname.isEmpty ? "청년" : appState.nickname)님")
                .font(.system(size: 30, weight: .heavy))
                .foregroundColor(Re20sColor.ink)

            Text("오늘도 내 속도대로 가볍게 시작해요.")
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(Re20sColor.subText)
        }
    }

    private var mainHeroCard: some View {
        ZStack(alignment: .bottomTrailing) {
            RoundedRectangle(cornerRadius: 34)
                .fill(Color.white.opacity(0.56))
                .background(
                    RoundedRectangle(cornerRadius: 34)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.84),
                                    Re20sColor.sage.opacity(0.12),
                                    Re20sColor.neoMint.opacity(0.10)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 34)
                        .stroke(Color.white.opacity(0.76), lineWidth: 1)
                )
                .shadow(color: Re20sColor.sage.opacity(0.16), radius: 24, x: 0, y: 14)

            VStack(alignment: .leading, spacing: 14) {
                Text("TODAY")
                    .font(.system(size: 12, weight: .bold))
                    .tracking(1.4)
                    .foregroundColor(Re20sColor.deepSage)
                    .padding(.vertical, 7)
                    .padding(.horizontal, 13)
                    .background(Re20sColor.sage.opacity(0.14))
                    .cornerRadius(18)

                Text("오늘의 흔들림도,\n내 탓만은 아니야.")
                    .font(.system(size: 25, weight: .heavy))
                    .foregroundColor(Re20sColor.ink)
                    .lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)

                Text("수원시 청년 지원 센터와 함께 내 삶의 구조를 보고, 나에게 맞는 루틴을 찾아봐요.")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Re20sColor.subText)
                    .lineSpacing(5)
                    .padding(.trailing, 80)

                Spacer(minLength: 20)
            }
            .padding(24)
            .frame(maxWidth: .infinity, alignment: .leading)

        
        }
        .frame(height: 260)
    }

    private var diagnosisStatusCard: some View {
        Re20sGlassCard {
            VStack(alignment: .leading, spacing: 18) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("나의 CORE 진단")
                            .font(.system(size: 22, weight: .heavy))
                            .foregroundColor(Re20sColor.ink)

                        Text(appState.hasDiagnosisResult ? "진단 결과를 다시 확인하고 솔루션으로 이어가요." : "아직 진단 전이에요. 지금 나를 흔드는 구조부터 확인해볼까요?")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(Re20sColor.subText)
                            .lineSpacing(4)
                    }

                    Spacer()

                    Image(systemName: appState.hasDiagnosisResult ? "checkmark.seal.fill" : "questionmark.circle.fill")
                        .font(.system(size: 30))
                        .foregroundColor(appState.hasDiagnosisResult ? Re20sColor.sage : Re20sColor.softOrange)
                }

                if appState.hasDiagnosisResult {
                    resultBadge
                } else {
                    beforeDiagnosisBox
                }

                NavigationLink {
                    if appState.hasDiagnosisResult {
                        DiagnosisResultView()
                    } else {
                        DiagnosisView()
                    }
                } label: {
                    Text(appState.hasDiagnosisResult ? "진단 결과 보러가기" : "진단하러가기")
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
                        .shadow(color: Re20sColor.sage.opacity(0.22), radius: 14, x: 0, y: 7)
                }

                if appState.hasDiagnosisResult {
                    resultImageCard
                }
            }
        }
    }

    private var resultBadge: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("진단 완료")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .background(Re20sColor.sage)
                    .cornerRadius(14)

                Text(appState.diagnosisResultType)
                    .font(.system(size: 28, weight: .heavy))
                    .foregroundColor(Re20sColor.deepSage)
            }

            Spacer()

            Text("CORE")
                .font(.system(size: 14, weight: .heavy))
                .foregroundColor(Re20sColor.sage)
                .padding(.vertical, 9)
                .padding(.horizontal, 14)
                .background(Re20sColor.sage.opacity(0.12))
                .cornerRadius(18)
        }
        .padding(18)
        .background(Color.white.opacity(0.58))
        .cornerRadius(24)
    }

    private var beforeDiagnosisBox: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(Re20sColor.sage.opacity(0.14))
                    .frame(width: 56, height: 56)

                Image(systemName: "sparkle.magnifyingglass")
                    .font(.title2)
                    .foregroundColor(Re20sColor.deepSage)
            }

            VStack(alignment: .leading, spacing: 5) {
                Text("진단 전")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Re20sColor.ink)

                Text("20문항으로 내 CORE 유형을 확인해요.")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(Re20sColor.subText)
            }

            Spacer()
        }
        .padding(18)
        .background(Color.white.opacity(0.58))
        .cornerRadius(24)
    }

    private var resultImageCard: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white.opacity(0.55))
                .frame(height: 240)

            Circle()
                .fill(Re20sColor.neoMint.opacity(0.15))
                .frame(width: 150, height: 150)
                .blur(radius: 6)
                .offset(x: 72, y: -54)

            Circle()
                .fill(Re20sColor.sage.opacity(0.12))
                .frame(width: 120, height: 120)
                .blur(radius: 6)
                .offset(x: -76, y: 36)

            Image(resultImageName)
                .resizable()
                .scaledToFit()
                .frame(height: 230)
                .offset(y: -8)
        }
    }

    private var quickMenuSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Re20sSectionTitle(
                "바로가기",
                subtitle: "오늘 할 수 있는 작은 액션을 골라봐요."
            )

            HStack(spacing: 12) {
                NavigationLink {
                    RecordView()
                } label: {
                    QuickActionCard(
                        icon: "calendar",
                        title: "감정 기록",
                        subtitle: "오늘 상태 체크"
                    )
                }

                NavigationLink {
                    SolutionView()
                } label: {
                    QuickActionCard(
                        icon: "leaf",
                        title: "솔루션",
                        subtitle: "미션 보러가기"
                    )
                }
            }
        }
    }
}

struct QuickActionCard: View {
    let icon: String
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack {
                Circle()
                    .fill(Re20sColor.sage.opacity(0.14))
                    .frame(width: 46, height: 46)

                Image(systemName: icon)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Re20sColor.deepSage)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Re20sColor.ink)

                Text(subtitle)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(Re20sColor.subText)
            }
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.56))
        .cornerRadius(24)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.white.opacity(0.7), lineWidth: 1)
        )
        .shadow(color: Re20sColor.sage.opacity(0.10), radius: 14, x: 0, y: 8)
    }
}

#Preview {
    HomeView()
        .environmentObject(AppState())
}
