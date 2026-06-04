import SwiftUI

struct MyPageView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationStack {
            ZStack {
                Re20sBackground()

                ScrollView {
                    VStack(spacing: 26) {
                        profileCard

                        mileageCard

                        refundCard

                        infoCard

                        diagnosisCard

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

    private var profileCard: some View {
        Re20sGlassCard {
            VStack(spacing: 14) {
                Image("suwonieface")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .offset(y: -8)

                Text(appState.nickname.isEmpty ? "나의 페이지" : "\(appState.nickname)님의 페이지")
                    .font(.system(size: 26, weight: .heavy))
                    .foregroundColor(Re20sColor.ink)

                Text("나에게 맞는 루틴과 리워드를 확인해요.")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Re20sColor.subText)
            }
            .frame(maxWidth: .infinity)
        }
    }

    private var mileageCard: some View {
        Re20sGlassCard {
            VStack(alignment: .leading, spacing: 14) {
                Text("CORE 마일리지")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(Re20sColor.deepSage)

                HStack(alignment: .bottom, spacing: 6) {
                    Text("\(appState.corePoint)")
                        .font(.system(size: 44, weight: .heavy))
                        .foregroundColor(Re20sColor.sage)

                    Text("CORE")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Re20sColor.subText)
                        .padding(.bottom, 8)
                }

                Text("미션을 인증할수록 포인트가 쌓여요.")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Re20sColor.subText)
            }
        }
    }

    private var refundCard: some View {
        Re20sGlassCard {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("경기지역화폐 환급")
                            .font(.system(size: 20, weight: .heavy))
                            .foregroundColor(Re20sColor.ink)

                        Text("CORE 포인트를 경기지역화폐로 전환해요.")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(Re20sColor.subText)
                    }

                    Spacer()

                    Image(systemName: "creditcard.fill")
                        .font(.system(size: 28))
                        .foregroundColor(Re20sColor.sage)
                }

                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("환급 기준")
                            .font(.caption)
                            .foregroundColor(Re20sColor.subText)

                        Text("1,000 CORE = 1,000원")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Re20sColor.deepSage)
                    }

                    Spacer()

                    Text(appState.corePoint >= 1000 ? "환급 가능" : "포인트 부족")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(appState.corePoint >= 1000 ? Re20sColor.deepSage : .gray)
                        .padding(.vertical, 7)
                        .padding(.horizontal, 12)
                        .background(appState.corePoint >= 1000 ? Re20sColor.sage.opacity(0.16) : Color.gray.opacity(0.12))
                        .cornerRadius(14)
                }
                .padding()
                .background(Color.white.opacity(0.55))
                .cornerRadius(18)

                NavigationLink {
                    LocalPayRefundView()
                        .environmentObject(appState)
                } label: {
                    Text("경기지역화폐로 환급하기")
                        .font(.system(size: 15, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(
                            appState.corePoint >= 1000
                            ? LinearGradient(
                                colors: [Re20sColor.sage, Re20sColor.neoMint],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            : LinearGradient(
                                colors: [Color.gray.opacity(0.45), Color.gray.opacity(0.35)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .foregroundColor(.white)
                        .cornerRadius(18)
                }
                .disabled(appState.corePoint < 1000)

                Text("※ 실제 환급 연동 전, 서비스 시연을 위한 예시 화면입니다.")
                    .font(.caption2)
                    .foregroundColor(Re20sColor.subText)
            }
        }
    }

    private var infoCard: some View {
        Re20sGlassCard {
            VStack(alignment: .leading, spacing: 16) {
                Re20sSectionTitle("내 정보")

                MyInfoRow(title: "이름", value: appState.name.isEmpty ? "미입력" : appState.name)
                MyInfoRow(title: "닉네임", value: appState.nickname.isEmpty ? "미입력" : appState.nickname)
                MyInfoRow(title: "성별/나이", value: appState.genderAge.isEmpty ? "미입력" : appState.genderAge)
                MyInfoRow(title: "현재 상태", value: appState.currentStatus.isEmpty ? "미입력" : appState.currentStatus)
            }
        }
    }

    private var diagnosisCard: some View {
        Re20sGlassCard {
            VStack(alignment: .leading, spacing: 14) {
                Re20sSectionTitle("진단 결과")

                if appState.hasDiagnosisResult {
                    Text(appState.diagnosisResultType)
                        .font(.system(size: 24, weight: .heavy))
                        .foregroundColor(Re20sColor.deepSage)
                } else {
                    Text("아직 진단을 진행하지 않았어요.")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(Re20sColor.subText)
                }
            }
        }
    }
}

struct MyInfoRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(Re20sColor.subText)

            Spacer()

            Text(value)
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(Re20sColor.ink)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    MyPageView()
        .environmentObject(AppState())
}
