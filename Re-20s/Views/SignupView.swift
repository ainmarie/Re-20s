import SwiftUI

struct SignupView: View {
    @EnvironmentObject var appState: AppState

    @State private var nickname: String = ""
    @State private var name: String = ""

    @State private var selectedStatus: String = "학생"
    @State private var selectedAge: Double = 20
    @State private var selectedGender: String = "여성"

    private let statusOptions = [
        "학생",
        "직장인",
        "취준생",
        "무직",
        "아르바이트",
        "프리랜서",
        "휴학생",
        "기타"
    ]

    private let genderOptions = [
        "여성",
        "남성"
    ]

    private var canSignup: Bool {
        !nickname.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Re20sColor.offWhite
                    .ignoresSafeArea()

                LinearGradient(
                    colors: [
                        Re20sColor.sage.opacity(0.16),
                        Re20sColor.offWhite,
                        Re20sColor.neoMint.opacity(0.12)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 28) {
                        headerSection

                        VStack(spacing: 22) {
                            FloatingInputField(
                                title: "닉네임",
                                placeholder: "앱에서 사용할 이름",
                                text: $nickname
                            )

                            FloatingInputField(
                                title: "이름",
                                placeholder: "실명을 입력해 주세요",
                                text: $name
                            )

                            statusSection

                            ageSliderSection

                            genderChipSection
                        }
                        .padding(22)
                        .background(
                            RoundedRectangle(cornerRadius: 28)
                                .fill(Color.white.opacity(0.58))
                                .background(
                                    RoundedRectangle(cornerRadius: 28)
                                        .fill(
                                            LinearGradient(
                                                colors: [
                                                    Color.white.opacity(0.82),
                                                    Re20sColor.sage.opacity(0.08),
                                                    Re20sColor.neoMint.opacity(0.08)
                                                ],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 28)
                                        .stroke(Color.white.opacity(0.75), lineWidth: 1)
                                )
                                .shadow(color: Re20sColor.sage.opacity(0.14), radius: 22, x: 0, y: 12)
                        )

                        Button {
                            signup()
                        } label: {
                            Text("가입 완료")
                                .font(.system(size: 16, weight: .bold))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 17)
                                .background(
                                    LinearGradient(
                                        colors: canSignup
                                        ? [Re20sColor.sage, Re20sColor.neoMint]
                                        : [Color.gray.opacity(0.45), Color.gray.opacity(0.35)],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .foregroundColor(.white)
                                .cornerRadius(22)
                                .shadow(
                                    color: canSignup ? Re20sColor.sage.opacity(0.22) : Color.clear,
                                    radius: 14,
                                    x: 0,
                                    y: 7
                                )
                        }
                        .disabled(!canSignup)

                        if !canSignup {
                            Text("닉네임과 이름은 필수 입력 항목이에요.")
                                .font(.caption)
                                .foregroundColor(Re20sColor.subText)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }

                        OperatorInfoView()

                        Spacer(minLength: 40)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 30)
                    .padding(.bottom, 28)
                }
            }
            .navigationBarHidden(true)
        }
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("RE:20s 시작하기")
                .font(.system(size: 32, weight: .heavy))
                .foregroundColor(Re20sColor.ink)

            Text("딱 필요한 정보만 가볍게 입력해요.")
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(Re20sColor.subText)
        }
    }

    private var statusSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("현재 상태")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Re20sColor.subText)

            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                spacing: 10
            ) {
                ForEach(statusOptions, id: \.self) { status in
                    Button {
                        withAnimation(.spring(response: 0.28, dampingFraction: 0.82)) {
                            selectedStatus = status
                        }
                    } label: {
                        Text(status)
                            .font(.system(size: 14, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(
                                selectedStatus == status
                                ? Re20sColor.sage.opacity(0.18)
                                : Color.white.opacity(0.58)
                            )
                            .foregroundColor(
                                selectedStatus == status
                                ? Re20sColor.deepSage
                                : Re20sColor.subText
                            )
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(
                                        selectedStatus == status
                                        ? Re20sColor.sage.opacity(0.55)
                                        : Color.clear,
                                        lineWidth: 1
                                    )
                            )
                    }
                }
            }
        }
    }

    private var ageSliderSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("나이")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Re20sColor.subText)

                Spacer()

                Text("\(Int(selectedAge))세")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Re20sColor.deepSage)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 14)
                    .background(Re20sColor.sage.opacity(0.14))
                    .cornerRadius(18)
            }

            Slider(value: $selectedAge, in: 14...39, step: 1)
                .tint(Re20sColor.sage)

            HStack {
                Text("14")
                Spacer()
                Text("20")
                Spacer()
                Text("30")
                Spacer()
                Text("39")
            }
            .font(.caption)
            .foregroundColor(.gray)
        }
        .padding(16)
        .background(Color.white.opacity(0.55))
        .cornerRadius(20)
    }

    private var genderChipSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("성별")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Re20sColor.subText)

            ZStack(alignment: selectedGender == "여성" ? .leading : .trailing) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white.opacity(0.58))
                    .frame(height: 54)

                RoundedRectangle(cornerRadius: 18)
                    .fill(
                        LinearGradient(
                            colors: [
                                Re20sColor.sage,
                                Re20sColor.neoMint
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: UIScreen.main.bounds.width / 2 - 46, height: 46)
                    .padding(4)
                    .shadow(color: Re20sColor.sage.opacity(0.2), radius: 10, x: 0, y: 5)

                HStack(spacing: 0) {
                    ForEach(genderOptions, id: \.self) { gender in
                        Button {
                            withAnimation(.spring(response: 0.32, dampingFraction: 0.82)) {
                                selectedGender = gender
                            }
                        } label: {
                            Text(gender)
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(selectedGender == gender ? .white : Re20sColor.subText)
                                .frame(maxWidth: .infinity)
                                .frame(height: 54)
                        }
                    }
                }
            }
        }
    }

    private func signup() {
        appState.nickname = nickname.trimmingCharacters(in: .whitespacesAndNewlines)
        appState.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        appState.currentStatus = selectedStatus
        appState.genderAge = "\(selectedGender) / \(Int(selectedAge))세"
        appState.isSignedUp = true
    }
}

struct FloatingInputField: View {
    let title: String
    let placeholder: String

    @Binding var text: String
    @FocusState private var isFocused: Bool

    private var shouldFloat: Bool {
        isFocused || !text.isEmpty
    }

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.white.opacity(0.58))
                .frame(height: 70)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: shouldFloat ? 12 : 16, weight: .semibold))
                    .foregroundColor(isFocused ? Re20sColor.sage : Re20sColor.subText)
                    .offset(y: shouldFloat ? 0 : 13)
                    .animation(.easeInOut(duration: 0.18), value: shouldFloat)

                ZStack(alignment: .leading) {
                    if text.isEmpty && shouldFloat {
                        Text(placeholder)
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(Color.gray.opacity(0.55))
                    }

                    TextField("", text: $text)
                        .focused($isFocused)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Re20sColor.ink)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                .opacity(shouldFloat ? 1 : 0.01)
            }
            .padding(.horizontal, 16)

            VStack {
                Spacer()

                Rectangle()
                    .fill(isFocused ? Re20sColor.sage : Color.gray.opacity(0.18))
                    .frame(height: isFocused ? 2 : 1)
                    .padding(.horizontal, 16)
                    .animation(.easeInOut(duration: 0.18), value: isFocused)
            }
        }
        .frame(height: 70)
        .contentShape(Rectangle())
        .onTapGesture {
            isFocused = true
        }
    }
}

#Preview {
    SignupView()
        .environmentObject(AppState())
}
