# Geology Images

A tvOS app for Apple TV that displays high-quality geological images as a slideshow with metadata overlays and smooth crossfade transitions.

## Features

- **Full-screen slideshow** - Displays geological images in stunning full-screen mode
- **Crossfade transitions** - Smooth opacity transitions between images with configurable duration
- **Metadata overlays** - Shows title, description, location, and scale for each image
- **Remote control support** - Full Apple TV remote integration:
  - Play/Pause button to toggle slideshow
  - Left/Right to skip between images
  - Up/Down to show/hide controls
  - Long press to access settings
- **Configurable settings** - Adjust display duration (5-60 seconds) and transition speed
- **Persistent preferences** - Settings are saved between app launches

## Requirements

- tvOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/kwdhinde/GeologyImages.git
   ```

2. Open `GeologyImages.xcodeproj` in Xcode

3. Add your geological images to the asset catalog:
   - Navigate to `Assets.xcassets/GeologyImages`
   - Add image files to the existing imagesets or create new ones
   - Recommended resolution: 1920x1080 or higher for optimal display

4. Update `Resources/images.json` with metadata for your images:
   ```json
   {
     "id": "unique-uuid",
     "imageName": "asset_name",
     "title": "Image Title",
     "description": "Description of the geological formation",
     "location": "Geographic location",
     "scale": "Hand Sample | Outcrop | Landscape | Microscopic"
   }
   ```

5. Set your development team in Signing & Capabilities

6. Build and run on Apple TV Simulator or device

## Project Structure

```
GeologyImages/
├── GeologyImagesApp.swift          # App entry point
├── Models/
│   ├── GeologyImage.swift          # Image data model
│   └── AppSettings.swift           # User preferences
├── Views/
│   ├── SlideshowView.swift         # Main slideshow display
│   ├── ImageOverlayView.swift      # Metadata overlay
│   ├── ControlsOverlayView.swift   # Playback controls
│   └── SettingsView.swift          # Settings screen
├── ViewModels/
│   └── SlideshowViewModel.swift    # Slideshow logic & state
├── Resources/
│   └── images.json                 # Image metadata catalog
└── Assets.xcassets/
    └── GeologyImages/              # Bundled image assets
```

## Usage

### Controls

| Action | Remote Input |
|--------|--------------|
| Play/Pause | Play/Pause button |
| Previous image | Swipe or click left |
| Next image | Swipe or click right |
| Show/hide controls | Swipe up or down |
| Open settings | Long press select button |

### Settings

- **Display Duration** - How long each image is shown (5-60 seconds)
- **Transition Duration** - Length of crossfade animation (0.5-3.0 seconds)
- **Show Image Information** - Toggle metadata overlay visibility

## Sample Images

The app includes placeholder asset entries for 8 geological formations:

- Granite Formation (Sierra Nevada, California)
- Columnar Basalt (Giant's Causeway, Northern Ireland)
- Cross-Bedded Sandstone (Zion National Park, Utah)
- Carrara Marble (Carrara, Italy)
- Obsidian Glass (Newberry Volcano, Oregon)
- Fossiliferous Limestone (White Cliffs of Dover, England)
- Banded Gneiss (Canadian Shield, Ontario)
- Quartz Vein (Mother Lode, California)

Replace the placeholder imagesets with actual photographs to complete the app.

## Architecture

The app follows the MVVM (Model-View-ViewModel) pattern:

- **Models** define data structures and persistence
- **Views** handle UI rendering with SwiftUI
- **ViewModels** manage state and business logic

## License

MIT License
