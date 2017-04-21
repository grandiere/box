import Foundation

class MLanding
{
    let items:[MLandingItem]
    
    init()
    {
        let itemTheGrid:MLandingItemTheGrid = MLandingItemTheGrid()
        let itemProfile:MLandingItemTheProfile = MLandingItemTheProfile()
        let itemStats:MLandingItemTheStats = MLandingItemTheStats()
        let itemBoards:MLandingItemTheBoards = MLandingItemTheBoards()
        
        items = [
            itemTheGrid,
            itemProfile,
            itemStats,
            itemBoards]
    }
}
