import SwiftUI

struct OpeningView: View {
    @EnvironmentObject var appState: AppState
    @State private var currentPage: Int = 0
    @State private var floating: Bool = false

    private let pages: [OpeningPage] = [
        OpeningPage(
            badge: "RE:20s",
            title: "내 탓 말고,\n구조부터 보기",
            subtitle: "나를 바꾸기 전에,\n나를 둘러싼 구조를 먼저 봐요.",
            description: "수원시 청년 지원 센터와 함께 내 일상에 영향을 주는 구조적 요인을 가볍게 진단해요.",
            imageName: "suwonieopening",
            mainColor: Re20sColor.sage,
            accentColor: Re20sColor.neoMint,
            isFinal: false
        ),
        OpeningPage(
            badge: "STEP 01",
            title: "구조적 문제 진단",
            subtitle: "지금 나를 흔드는 원인을\nCORE로 확인해요.",
            description: "물리적, 심리적, 시스템적, 문화적 구조까지. 내 문제가 아니라 구조의 신호일 수 있어요.",
            imageName: "testsuwonie",
            mainColor: Re20sColor.sage,
            accentColor: Re20sColor.mint,
            isFinal: false
        ),
        OpeningPage(
            badge: "STEP 02",
            title: "진단 결과 확인",
            subtitle: "나는 어떤 CORE 유형일까?",
            description: "C · O · R · E 점수를 통해 지금 나에게 가장 크게 작용하는 영역을 한눈에 확인해요.",
            imageName: "solutionsuwonie",
            mainColor: Re20sColor.deepSage,
            accentColor: Re20sColor.softGreen,
            isFinal: false
        ),
        OpeningPage(
            badge: "STEP 03",
            title: "솔루션 추천",
            subtitle: "내 유형에 맞는\n실천 루틴을 받아요.",
            description: "디지털 디톡스, 휴식 미션, 공간 배치, 문화센터 연계까지. 부담 없는 미션으로 시작해요.",
            imageName: "missionsuwonie",
            mainColor: Re20sColor.neoMint,
            accentColor: Re20sColor.sage,
            isFinal: false
        ),
        OpeningPage(
            badge: "STEP 04",
            title: "미션 수행 후 리워드",
            subtitle: "실천의 경험을\n포인트와 함께 쌓아요.",
            description: "작은 실천을 기록하고 CORE 포인트를 받아요. 변화는 거창하지 않아도 충분해요.",
            imageName: "rewardsuwonie",
            mainColor: Re20sColor.softOrange,
            accentColor: Re20sColor.sage,
            isFinal: false
        ),
        OpeningPage(
            badge: "START",
            title: "수원시 청년 지원 센터와 함께",
            subtitle: "구조를 알면,\n조금 더 나아질 수 있어요.",
            description: "RE:20s는 청년의 어려움을 개인의 탓으로만 보지 않아요. 지금의 나를 둘러싼 구조를 이해하고, 나에게 맞는 작은 변화를 시작해요.",
            imageName: "",
            mainColor: Re20sColor.sage,
            accentColor: Re20sColor.neoMint,
            isFinal: true
        )
    ]

    private var currentPageData: OpeningPage {
        pages[currentPage]
    }

    var body: some View {
        ZStack {
            Re20sColor.offWhite
                .ignoresSafeArea()

            backgroundGradient

            decorativeObjects

            VStack(spacing: 0) {
                TabView(selection: $currentPage) {
                    ForEach(pages.indices, id: \.self) { index in
                        OpeningPageView(
                            page: pages[index],
                            floating: floating
                        )
                        .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))

                PageIndicator(
                    totalCount: pages.count,
                    currentIndex: currentPage,
                    activeColor: currentPageData.mainColor
                )
                .padding(.bottom, 18)

                bottomButtons
            }
        }
        .onAppear {
            withAnimation(
                .easeInOut(duration: 1.7)
                .repeatForever(autoreverses: true)
            ) {
                floating = true
            }
        }
    }

    private var backgroundGradient: some View {
        LinearGradient(
            colors: [
                currentPageData.mainColor.opacity(0.22),
                Re20sColor.offWhite,
                currentPageData.accentColor.opacity(0.16)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
        .animation(.easeInOut(duration: 0.35), value: currentPage)
    }

    private var decorativeObjects: some View {
        ZStack {
            Circle()
                .fill(currentPageData.mainColor.opacity(0.13))
                .frame(width: 220, height: 220)
                .blur(radius: 20)
                .offset(x: -150, y: -310)

            Circle()
                .fill(currentPageData.accentColor.opacity(0.16))
                .frame(width: 260, height: 260)
                .blur(radius: 24)
                .offset(x: 160, y: 280)

            RoundedRectangle(cornerRadius: 28)
                .fill(Color.white.opacity(0.34))
                .frame(width: 82, height: 82)
                .rotationEffect(.degrees(18))
                .blur(radius: 1)
                .offset(x: 138, y: -210)

            Image(systemName: "leaf.fill")
                .font(.system(size: 24, weight: .light))
                .foregroundColor(currentPageData.mainColor.opacity(0.18))
                .offset(x: -135, y: 210)

            Image(systemName: "sparkle")
                .font(.system(size: 26, weight: .light))
                .foregroundColor(currentPageData.accentColor.opacity(0.35))
                .offset(x: 125, y: -120)
        }
        .animation(.easeInOut(duration: 0.35), value: currentPage)
    }

    private var bottomButtons: some View {
        HStack(spacing: 12) {
            if currentPage > 0 {
                Button {
                    withAnimation(.spring(response: 0.34, dampingFraction: 0.82)) {
                        currentPage -= 1
                    }
                } label: {
                    Text("이전")
                        .font(.system(size: 16, weight: .semibold))
                        .frame(width: 88)
                        .padding(.vertical, 16)
                        .background(Color.white.opacity(0.72))
                        .foregroundColor(.gray)
                        .cornerRadius(22)
                        .overlay(
                            RoundedRectangle(cornerRadius: 22)
                                .stroke(Color.white.opacity(0.7), lineWidth: 1)
                        )
                }
            }

            Button {
                if currentPage < pages.count - 1 {
                    withAnimation(.spring(response: 0.34, dampingFraction: 0.82)) {
                        currentPage += 1
                    }
                } else {
                    appState.hasSeenOpening = true
                }
            } label: {
                Text(currentPage == pages.count - 1 ? "시작하기" : "다음")
                    .font(.system(size: 16, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        LinearGradient(
                            colors: [
                                currentPageData.mainColor,
                                currentPageData.accentColor
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .foregroundColor(.white)
                    .cornerRadius(22)
                    .shadow(color: currentPageData.mainColor.opacity(0.24), radius: 16, x: 0, y: 8)
            }
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 24)
    }
}

struct OpeningPage {
    let badge: String
    let title: String
    let subtitle: String
    let description: String
    let imageName: String
    let mainColor: Color
    let accentColor: Color
    let isFinal: Bool
}

struct OpeningPageView: View {
    let page: OpeningPage
    let floating: Bool

    var body: some View {
        VStack(spacing: 26) {
            Spacer(minLength: 24)

            VStack(spacing: 12) {
                Text(page.badge)
                    .font(.system(size: 12, weight: .bold))
                    .tracking(1.2)
                    .foregroundColor(page.mainColor)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(Color.white.opacity(0.58))
                    .cornerRadius(18)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color.white.opacity(0.65), lineWidth: 1)
                    )

                Text(page.title)
                    .font(.system(size: 32, weight: .heavy))
                    .foregroundColor(Re20sColor.ink)
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 28)
            }

            if page.isFinal {
                finalTextCard
            } else {
                visualCard
            }

            VStack(spacing: 12) {
                Text(page.subtitle)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(Re20sColor.ink)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)

                Text(page.description)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(Re20sColor.subText)
                    .multilineTextAlignment(.center)
                    .lineSpacing(6)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 30)
            }

            
            Spacer(minLength: 20)
        }
    }

    private var visualCard: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 34)
                .fill(Color.white.opacity(0.48))
                .background(
                    RoundedRectangle(cornerRadius: 34)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.78),
                                    page.mainColor.opacity(0.10),
                                    page.accentColor.opacity(0.10)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 34)
                        .stroke(Color.white.opacity(0.72), lineWidth: 1)
                )
                .shadow(color: page.mainColor.opacity(0.18), radius: 24, x: 0, y: 14)
                .frame(height: 284)

            Circle()
                .fill(page.accentColor.opacity(0.14))
                .frame(width: 150, height: 150)
                .blur(radius: 4)
                .offset(x: 70, y: -70)

            Circle()
                .fill(page.mainColor.opacity(0.12))
                .frame(width: 105, height: 105)
                .blur(radius: 5)
                .offset(x: -76, y: -34)

            if page.imageName.isEmpty {
                EmptyView()
            } else {
                Image(page.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 245)
                    .offset(y: floating ? -18 : -4)
                    .scaleEffect(floating ? 1.02 : 0.98)
                    .animation(
                        .easeInOut(duration: 1.7)
                        .repeatForever(autoreverses: true),
                        value: floating
                    )
            }
        }
        .padding(.horizontal, 26)
        .padding(.top, 4)
    }

    private var finalTextCard: some View {
        VStack(spacing: 20) {
            Image(systemName: "leaf.circle.fill")
                .font(.system(size: 54))
                .foregroundColor(page.mainColor)

            Text("RE:20s")
                .font(.system(size: 48, weight: .heavy))
                .foregroundColor(page.mainColor)

            Text("네 탓이 아니야.")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Re20sColor.ink)

            Text("수원시 청년 지원 센터와 함께\n구조를 알고, 내 삶을 다시 설계해요.")
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(Re20sColor.subText)
                .multilineTextAlignment(.center)
                .lineSpacing(6)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 284)
        .background(
            RoundedRectangle(cornerRadius: 34)
                .fill(Color.white.opacity(0.54))
                .background(
                    RoundedRectangle(cornerRadius: 34)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.84),
                                    page.mainColor.opacity(0.12),
                                    page.accentColor.opacity(0.12)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 34)
                        .stroke(Color.white.opacity(0.74), lineWidth: 1)
                )
                .shadow(color: page.mainColor.opacity(0.18), radius: 24, x: 0, y: 14)
        )
        .padding(.horizontal, 26)
        .padding(.top, 4)
    }
}

struct PageIndicator: View {
    let totalCount: Int
    let currentIndex: Int
    let activeColor: Color

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalCount, id: \.self) { index in
                Capsule()
                    .fill(index == currentIndex ? activeColor : Color.gray.opacity(0.22))
                    .frame(
                        width: index == currentIndex ? 26 : 8,
                        height: 8
                    )
                    .animation(.spring(response: 0.3, dampingFraction: 0.8), value: currentIndex)
            }
        }
    }
}

#Preview {
    OpeningView()
        .environmentObject(AppState())
}
