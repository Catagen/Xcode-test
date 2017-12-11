import SpriteKit

struct ImageNames {
    static let background = "background.png"
    static let playerLeft = "char_left.png"
    static let playerRight = "char_right.png"
    static let playerFront = "char_front.png"
    static let playerBack = "char_back.png"
    static let blockNormal = "tile.png"
    static let blockSpecial = "tile_special.png"
    static let blockEdge = "tile_edge.png"
    static let resetButton = "reset.png"
    static let box = "box.png"
}

struct zPositions {
    static let background:CGFloat = 0
    static let player:CGFloat = 10
    static let tile:CGFloat = 1
    static let box:CGFloat = 2
}

struct Maps {
    // Temporary struct for map loading
    static let map1 = [[55,56,57,64,65,66,68,69,70,73,74,75,77,78,79,84,85,86,87,88,92,93,94,101,102,103,104,105],[103,104,105],[55],[65,66,78]]
}

struct gameConfig {
    static let yDiff = 9
    static let xDiff = 1
    static let moveAnimation = 0.15
}
