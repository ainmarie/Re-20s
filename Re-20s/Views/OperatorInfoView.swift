import SwiftUI

struct OperatorInfoView: View {
    var body: some View {
        VStack(spacing: 6) {
            Divider()

            Text("운영주체")
                .font(.caption)
                .foregroundColor(.gray)

            Text("수원시 청년 지원 센터")
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundColor(.green)
        }
        .padding(.top, 12)
        .padding(.bottom, 8)
    }
}

#Preview {
    OperatorInfoView()
}
