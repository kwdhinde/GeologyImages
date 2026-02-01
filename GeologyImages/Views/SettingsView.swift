import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SlideshowViewModel
    @ObservedObject private var settings = AppSettings.shared
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Text("Display Duration")
                        Spacer()
                        Button(action: {
                            if settings.displayPeriod > settings.displayPeriodRange.lowerBound {
                                settings.displayPeriod -= 1.0
                            }
                        }) {
                            Image(systemName: "minus.circle.fill")
                                .font(.title2)
                        }
                        .buttonStyle(.plain)

                        Text("\(Int(settings.displayPeriod)) sec")
                            .frame(minWidth: 80)
                            .foregroundColor(.secondary)

                        Button(action: {
                            if settings.displayPeriod < settings.displayPeriodRange.upperBound {
                                settings.displayPeriod += 1.0
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                        }
                        .buttonStyle(.plain)
                    }

                    HStack {
                        Text("Transition Duration")
                        Spacer()
                        Button(action: {
                            if settings.transitionDuration > settings.transitionDurationRange.lowerBound {
                                settings.transitionDuration -= 0.5
                            }
                        }) {
                            Image(systemName: "minus.circle.fill")
                                .font(.title2)
                        }
                        .buttonStyle(.plain)

                        Text(String(format: "%.1f sec", settings.transitionDuration))
                            .frame(minWidth: 80)
                            .foregroundColor(.secondary)

                        Button(action: {
                            if settings.transitionDuration < settings.transitionDurationRange.upperBound {
                                settings.transitionDuration += 0.5
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                        }
                        .buttonStyle(.plain)
                    }
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
