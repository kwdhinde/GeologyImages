import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SlideshowViewModel
    @ObservedObject private var settings = AppSettings.shared
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Display Duration")
                            Spacer()
                            Text("\(Int(settings.displayPeriod)) seconds")
                                .foregroundColor(.secondary)
                        }

                        Slider(
                            value: $settings.displayPeriod,
                            in: settings.displayPeriodRange,
                            step: 1.0
                        )
                    }
                    .padding(.vertical, 8)

                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Transition Duration")
                            Spacer()
                            Text(String(format: "%.1f seconds", settings.transitionDuration))
                                .foregroundColor(.secondary)
                        }

                        Slider(
                            value: $settings.transitionDuration,
                            in: settings.transitionDurationRange,
                            step: 0.5
                        )
                    }
                    .padding(.vertical, 8)
                } header: {
                    Text("Timing")
                }

                Section {
                    Toggle("Show Image Information", isOn: $settings.showMetadata)
                } header: {
                    Text("Display")
                }

                Section {
                    HStack {
                        Text("Total Images")
                        Spacer()
                        Text("\(viewModel.images.count)")
                            .foregroundColor(.secondary)
                    }

                    HStack {
                        Text("Current Image")
                        Spacer()
                        Text("\(viewModel.currentIndex + 1) of \(viewModel.images.count)")
                            .foregroundColor(.secondary)
                    }
                } header: {
                    Text("Slideshow Info")
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                        viewModel.closeSettings()
                    }
                }
            }
        }
        .onDisappear {
            viewModel.closeSettings()
        }
    }
}

#Preview {
    SettingsView(viewModel: SlideshowViewModel())
}
