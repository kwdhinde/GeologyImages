import Foundation

struct GeologyImage: Identifiable, Codable, Equatable {
    let id: UUID
    let imageName: String
    let title: String
    let description: String
    let location: String?
    let scale: String?

    init(id: UUID = UUID(), imageName: String, title: String, description: String, location: String? = nil, scale: String? = nil) {
        self.id = id
        self.imageName = imageName
        self.title = title
        self.description = description
        self.location = location
        self.scale = scale
    }
}

extension GeologyImage {
    static func loadFromBundle() -> [GeologyImage] {
        guard let url = Bundle.main.url(forResource: "images", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let images = try? JSONDecoder().decode([GeologyImage].self, from: data) else {
            return GeologyImage.sampleImages
        }
        return images
    }

    static let sampleImages: [GeologyImage] = [
        GeologyImage(
            imageName: "granite_closeup",
            title: "Granite Formation",
            description: "Coarse-grained igneous rock with visible quartz, feldspar, and mica crystals formed from slowly cooling magma.",
            location: "Sierra Nevada, California",
            scale: "Hand Sample"
        ),
        GeologyImage(
            imageName: "basalt_columns",
            title: "Columnar Basalt",
            description: "Hexagonal columns formed by the slow cooling of thick lava flows, creating geometric fracture patterns.",
            location: "Giant's Causeway, Northern Ireland",
            scale: "Landscape"
        ),
        GeologyImage(
            imageName: "sandstone_layers",
            title: "Cross-Bedded Sandstone",
            description: "Ancient sand dune deposits showing characteristic angled layers from wind-driven deposition.",
            location: "Zion National Park, Utah",
            scale: "Outcrop"
        ),
        GeologyImage(
            imageName: "marble_texture",
            title: "Carrara Marble",
            description: "Metamorphosed limestone with distinctive veining patterns created by mineral impurities during recrystallization.",
            location: "Carrara, Italy",
            scale: "Hand Sample"
        ),
        GeologyImage(
            imageName: "obsidian_flow",
            title: "Obsidian Glass",
            description: "Volcanic glass formed from rapidly cooled silica-rich lava, showing conchoidal fracture patterns.",
            location: "Newberry Volcano, Oregon",
            scale: "Close-up"
        ),
        GeologyImage(
            imageName: "limestone_fossils",
            title: "Fossiliferous Limestone",
            description: "Marine sedimentary rock containing preserved shells and coral fragments from ancient sea floors.",
            location: "White Cliffs of Dover, England",
            scale: "Hand Sample"
        ),
        GeologyImage(
            imageName: "gneiss_banding",
            title: "Banded Gneiss",
            description: "High-grade metamorphic rock displaying alternating light and dark mineral bands from intense heat and pressure.",
            location: "Canadian Shield, Ontario",
            scale: "Outcrop"
        ),
        GeologyImage(
            imageName: "quartz_vein",
            title: "Quartz Vein",
            description: "Hydrothermal silica deposit filling fractures in host rock, often associated with gold mineralization.",
            location: "Mother Lode, California",
            scale: "Close-up"
        )
    ]
}
