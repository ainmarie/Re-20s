import SwiftUI

struct Re20sColor {
    static let offWhite = Color(red: 0.975, green: 0.965, blue: 0.94)
    static let warmWhite = Color(red: 0.992, green: 0.985, blue: 0.965)

    static let sage = Color(red: 0.47, green: 0.62, blue: 0.50)
    static let deepSage = Color(red: 0.25, green: 0.43, blue: 0.32)
    static let neoMint = Color(red: 0.35, green: 0.78, blue: 0.67)
    static let mint = Color(red: 0.65, green: 0.84, blue: 0.74)
    static let softGreen = Color(red: 0.77, green: 0.86, blue: 0.66)
    static let softOrange = Color(red: 0.93, green: 0.63, blue: 0.39)

    static let ink = Color(red: 0.13, green: 0.16, blue: 0.15)
    static let subText = Color(red: 0.42, green: 0.46, blue: 0.43)
}

struct Re20sBackground: View {
    var body: some View {
        ZStack {
            Re20sColor.offWhite
                .ignoresSafeArea()

            LinearGradient(
                colors: [
                    Re20sColor.sage.opacity(0.16),
                    Re20sColor.offWhite,
                    Re20sColor.neoMint.opacity(0.10)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            Circle()
                .fill(Re20sColor.sage.opacity(0.10))
                .frame(width: 220, height: 220)
                .blur(radius: 20)
                .offset(x: -150, y: -320)

            Circle()
                .fill(Re20sColor.neoMint.opacity(0.10))
                .frame(width: 260, height: 260)
                .blur(radius: 24)
                .offset(x: 160, y: 310)
        }
    }
}

struct Re20sGlassCard<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
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
                    .shadow(color: Re20sColor.sage.opacity(0.13), radius: 22, x: 0, y: 12)
            )
    }
}

struct Re20sSectionTitle: View {
    let title: String
    let subtitle: String?

    init(_ title: String, subtitle: String? = nil) {
        self.title = title
        self.subtitle = subtitle
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(size: 22, weight: .heavy))
                .foregroundColor(Re20sColor.ink)

            if let subtitle {
                Text(subtitle)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Re20sColor.subText)
                    .lineSpacing(4)
            }
        }
    }
}

struct Re20sPrimaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
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
    }
}
