import SwiftUI

struct ControlsOverlayView: View {
    @ObservedObject var viewModel: SlideshowViewModel

    var body: some View {
        VStack {
            HStack {
                Spacer()

                HStack(spacing: 8) {
                    Image(systemName: viewModel.isPlaying ? "play.fill" : "pause.fill")
                        .font(.caption)
                    Text(viewModel.isPlaying ? "Playing" : "Paused")
                        .font(.caption)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(.ultraThinMaterial)
                .clipShape(Capsule())
            }
            .padding(.horizontal, 60)
            .padding(.top, 40)

            Spacer()

            HStack(spacing: 60) {
                ControlButton(
                    systemImage: "backward.fill",
                    label: "Previous"
                ) {
                    viewModel.goToPreviousImage()
                }

                ControlButton(
                    systemImage: viewModel.isPlaying ? "pause.fill" : "play.fill",
                    label: viewModel.isPlaying ? "Pause" : "Play",
                    isLarge: true
                ) {
                    viewModel.togglePlayback()
                }

                ControlButton(
                    systemImage: "forward.fill",
                    label: "Next"
                ) {
                    viewModel.goToNextImage()
                }

                ControlButton(
                    systemImage: "gearshape.fill",
                    label: "Settings"
                ) {
                    viewModel.openSettings()
                }
            }
            .padding(.bottom, 60)
        }
    }
}

struct ControlButton: View {
    let systemImage: String
    let label: String
    var isLarge: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: systemImage)
                    .font(.system(size: isLarge ? 44 : 32))
                Text(label)
                    .font(.caption)
            }
            .foregroundColor(.white)
            .frame(width: isLarge ? 120 : 100, height: isLarge ? 100 : 80)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.card)
    }
}

#Preview {
    ZStack {
        Color.black
        ControlsOverlayView(viewModel: SlideshowViewModel())
    }
}
