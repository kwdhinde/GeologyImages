import SwiftUI

struct ImageOverlayView: View {
    let image: GeologyImage

    var body: some View {
        VStack {
            Spacer()

            VStack(alignment: .leading, spacing: 12) {
                Text(image.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Text(image.description)
                    .font(.body)
                    .foregroundColor(.white.opacity(0.9))
                    .lineLimit(3)

                HStack(spacing: 24) {
                    if let location = image.location {
                        Label(location, systemImage: "mappin.circle.fill")
                            .font(.callout)
                            .foregroundColor(.white.opacity(0.8))
                    }

                    if let scale = image.scale {
                        Label(scale, systemImage: "ruler.fill")
                            .font(.callout)
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
            }
            .padding(.horizontal, 80)
            .padding(.vertical, 40)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        .clear,
                        .black.opacity(0.3),
                        .black.opacity(0.7)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ZStack {
        Color.gray
        ImageOverlayView(image: GeologyImage.sampleImages[0])
    }
}
