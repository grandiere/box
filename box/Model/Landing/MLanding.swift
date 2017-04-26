import Foundation

class MLanding
{
    let items:[MLandingItem]
    let barItems:[MLandingBarProtocol]
    
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
        
        let barSettings:MLandingBarSettings = MLandingBarSettings()
        
        barItems = [
            barSettings]
    }
}
