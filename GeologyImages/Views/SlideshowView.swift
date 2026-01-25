import SwiftUI

struct SlideshowView: View {
    @StateObject private var viewModel = SlideshowViewModel()
    @ObservedObject private var settings = AppSettings.shared

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            if let currentImage = viewModel.currentImage {
                GeometryReader { geometry in
                    Image(currentImage.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .id(currentImage.id)
                        .transition(.opacity)
                }
                .ignoresSafeArea()

                if settings.showMetadata {
                    ImageOverlayView(image: currentImage)
                        .transition(.opacity)
                }
            } else {
                VStack(spacing: 20) {
                    Image(systemName: "photo.on.rectangle.angled")
                        .font(.system(size: 80))
                        .foregroundColor(.gray)
                    Text("No Images Available")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
            }

            if viewModel.showControls {
                ControlsOverlayView(viewModel: viewModel)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: settings.transitionDuration), value: viewModel.currentImage?.id)
        .onPlayPauseCommand {
            viewModel.togglePlayback()
        }
        .onMoveCommand { direction in
            switch direction {
            case .left:
                viewModel.goToPreviousImage()
            case .right:
                viewModel.goToNextImage()
            case .up, .down:
                viewModel.toggleControls()
            @unknown default:
                break
            }
        }
        .onExitCommand {
            if viewModel.showSettings {
                viewModel.closeSettings()
            } else if viewModel.showControls {
                viewModel.toggleControls()
            }
        }
        .onLongPressGesture(minimumDuration: 1.0) {
            viewModel.openSettings()
        }
        .sheet(isPresented: $viewModel.showSettings) {
            SettingsView(viewModel: viewModel)
        }
    }
}

#Preview {
    SlideshowView()
}
