import SwiftUI
import Combine

@MainActor
class SlideshowViewModel: ObservableObject {
    @Published var images: [GeologyImage] = []
    @Published var currentIndex: Int = 0
    @Published var isPlaying: Bool = true
    @Published var showControls: Bool = false
    @Published var showSettings: Bool = false

    private var timer: AnyCancellable?
    private var controlsTimer: AnyCancellable?
    private let settings: AppSettings

    var currentImage: GeologyImage? {
        guard !images.isEmpty, currentIndex >= 0, currentIndex < images.count else {
            return nil
        }
        return images[currentIndex]
    }

    var nextImage: GeologyImage? {
        guard !images.isEmpty else { return nil }
        let nextIndex = (currentIndex + 1) % images.count
        return images[nextIndex]
    }

    init(settings: AppSettings = .shared) {
        self.settings = settings
        loadImages()
        startTimer()
    }

    func loadImages() {
        images = GeologyImage.loadFromBundle()
        if images.isEmpty {
            images = GeologyImage.sampleImages
        }
    }

    func startTimer() {
        stopTimer()
        guard isPlaying else { return }

        timer = Timer.publish(every: settings.displayPeriod, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.advanceToNextImage()
            }
    }

    func stopTimer() {
        timer?.cancel()
        timer = nil
    }

    func togglePlayback() {
        isPlaying.toggle()
        if isPlaying {
            startTimer()
        } else {
            stopTimer()
        }
        showControlsBriefly()
    }

    func advanceToNextImage() {
        guard !images.isEmpty else { return }
        withAnimation(.easeInOut(duration: settings.transitionDuration)) {
            currentIndex = (currentIndex + 1) % images.count
        }
    }

    func goToPreviousImage() {
        guard !images.isEmpty else { return }
        withAnimation(.easeInOut(duration: settings.transitionDuration)) {
            currentIndex = (currentIndex - 1 + images.count) % images.count
        }
        resetTimerIfPlaying()
        showControlsBriefly()
    }

    func goToNextImage() {
        advanceToNextImage()
        resetTimerIfPlaying()
        showControlsBriefly()
    }

    private func resetTimerIfPlaying() {
        if isPlaying {
            startTimer()
        }
    }

    func showControlsBriefly() {
        showControls = true
        controlsTimer?.cancel()
        controlsTimer = Timer.publish(every: 3.0, on: .main, in: .common)
            .autoconnect()
            .first()
            .sink { [weak self] _ in
                withAnimation(.easeOut(duration: 0.3)) {
                    self?.showControls = false
                }
            }
    }

    func toggleControls() {
        if showControls {
            controlsTimer?.cancel()
            withAnimation(.easeOut(duration: 0.3)) {
                showControls = false
            }
        } else {
            showControlsBriefly()
        }
    }

    func openSettings() {
        showSettings = true
        stopTimer()
    }

    func closeSettings() {
        showSettings = false
        if isPlaying {
            startTimer()
        }
    }
}
