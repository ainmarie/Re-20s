import SwiftUI

struct LocalPayRefundView: View {
    @EnvironmentObject var appState: AppState
    @State private var isCompleted: Bool = false

    var body: some View {
        ZStack {
            Re20sBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: 26) {
                    headerSection

                    if isCompleted {
                        completedCard
                    } else {
                        refundApplyCard
                    }

                    noticeCard

                    Spacer(minLength: 80)
                }
                .padding(24)
            }
        }
        .navigationTitle("지역화폐 환급")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("경기지역화폐 환급")
                .font(.system(size: 30, weight: .heavy))
                .foregroundColor(Re20sColor.ink)

            Text("쌓인 CORE 포인트를 지역화폐로 전환하는 시연 화면이에요.")
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(Re20sColor.subText)
        }
    }

    private var refundApplyCard: some View {
        Re20sGlassCard {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("보유 마일리지")
                            .font(.caption)
                            .foregroundColor(Re20sColor.subText)

                        Text("\(appState.corePoint) CORE")
                            .font(.system(size: 34, weight: .heavy))
                            .foregroundColor(Re20sColor.deepSage)
                    }

                    Spacer()

                    Image(systemName: "wallet.pass.fill")
                        .font(.system(size: 38))
                        .foregroundColor(Re20sColor.sage)
                }

                VStack(alignment: .leading, spacing: 10) {
                    RefundInfoRow(title: "환급 가능 금액", value: "1,000원")
                    RefundInfoRow(title: "차감 포인트", value: "1,000 CORE")
                    RefundInfoRow(title: "지급 방식", value: "경기지역화폐 모바일 쿠폰")
                }
                .padding()
                .background(Color.white.opacity(0.55))
                .cornerRadius(18)

                Button {
                    if appState.corePoint >= 1000 {
                        appState.corePoint -= 1000

                        withAnimation(.spring(response: 0.35, dampingFraction: 0.82)) {
                            isCompleted = true
                        }
                    }
                } label: {
                    Text("1,000원 환급 신청하기")
                        .font(.system(size: 16, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            LinearGradient(
                                colors: [Re20sColor.sage, Re20sColor.neoMint],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .foregroundColor(.white)
                        .cornerRadius(22)
                }
                .disabled(appState.corePoint < 1000)
            }
        }
    }

    private var completedCard: some View {
        Re20sGlassCard {
            VStack(spacing: 22) {
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 58))
                    .foregroundColor(Re20sColor.sage)

                VStack(spacing: 8) {
                    Text("환급이 완료되었어요")
                        .font(.system(size: 26, weight: .heavy))
                        .foregroundColor(Re20sColor.ink)

                    Text("경기지역화폐 모바일 쿠폰이 발급되었습니다.")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(Re20sColor.subText)
                        .multilineTextAlignment(.center)
                }

                fakeBarcode

                VStack(spacing: 6) {
                    Text("PIN 번호")
                        .font(.caption)
                        .foregroundColor(Re20sColor.subText)

                    Text("4582-9281-3312")
                        .font(.system(size: 22, weight: .heavy))
                        .foregroundColor(Re20sColor.deepSage)
                        .tracking(1.2)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white.opacity(0.58))
                .cornerRadius(18)

                Text("마이페이지에서 차감된 CORE 포인트를 확인할 수 있어요.")
                    .font(.caption)
                    .foregroundColor(Re20sColor.subText)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
        }
    }

    private var fakeBarcode: some View {
        VStack(spacing: 12) {
            HStack(spacing: 4) {
                ForEach(0..<26, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 1)
                        .fill(Re20sColor.ink)
                        .frame(
                            width: barcodeWidth(index),
                            height: 70
                        )
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)

            Text("경기지역화폐 모바일 상품권")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(Re20sColor.subText)
        }
    }

    private var noticeCard: some View {
        Re20sGlassCard {
            VStack(alignment: .leading, spacing: 10) {
                Text("시연 안내")
                    .font(.system(size: 18, weight: .heavy))
                    .foregroundColor(Re20sColor.ink)

                Text("본 화면은 서비스 프로토타입 시연을 위한 예시입니다. 실제 환급 기능은 향후 경기지역화폐 및 관련 기관 연동 이후 제공되는 기능으로 설계되었습니다.")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(Re20sColor.subText)
                    .lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    private func barcodeWidth(_ index: Int) -> CGFloat {
        let widths: [CGFloat] = [2, 4, 1, 3, 5, 2, 1, 4, 3, 2, 5, 1, 3, 4, 2, 1, 5, 3, 2, 4, 1, 3, 5, 2, 1, 4]
        return widths[index % widths.count]
    }
}

struct RefundInfoRow: View {
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
    }
}

#Preview {
    LocalPayRefundView()
        .environmentObject(AppState())
}
