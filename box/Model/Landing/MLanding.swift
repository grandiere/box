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
            itemBoards,
            itemProfile,
            itemStats]
        
        let barSettings:MLandingBarSettings = MLandingBarSettings()
        let barStore:MLandingBarStore = MLandingBarStore()
        let barHelp:MLandingBarHelp = MLandingBarHelp()
        
        barItems = [
            barSettings,
            barStore,
            barHelp]
    }
}
