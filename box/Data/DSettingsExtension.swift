import Foundation
import CoreData

extension DSettings
{
    static let kMaxFroobShots:Int16 = 3
    static let kWaitingTime:TimeInterval = 600
    
    //MARK: private
    
    private func asyncRecentEntry(
        wordId:String,
        word:String,
        languageRaw:Int16,
        region:String?)
    {
        guard
        
            let recent:[DEntry] = self.recent?.array as? [DEntry]
        
        else
        {
            return
        }
        
        let timestamp:TimeInterval = Date().timeIntervalSince1970
        var entry:DEntry?
        
        for recentEntry:DEntry in recent
        {
            if recentEntry.wordId == wordId
            {
                if recentEntry.language == languageRaw
                {
                    entry = recentEntry
                    removeFromRecent(recentEntry)
                    
                    break
                }
            }
        }
        
        if let entry:DEntry = entry
        {
            entry.timestamp = timestamp
            insertIntoRecent(entry, at:0)
            
            DManager.sharedInstance?.save()
        }
        else
        {
            DManager.sharedInstance?.createData(
                entityName:DEntry.entityName)
            { [weak self] (data) in
                
                guard
                
                    let entry:DEntry = data as? DEntry
                
                else
                {
                    return
                }
                
                entry.wordId = wordId
                entry.word = word
                entry.language = languageRaw
                entry.region = region
                entry.timestamp = timestamp
                
                self?.insertIntoRecent(entry, at:0)
                
                DManager.sharedInstance?.save()
            }
        }
    }
    
    private func asyncMakeFavorite(
        wordId:String,
        word:String,
        languageRaw:Int16,
        region:String?)
    {
        let timestamp:TimeInterval = Date().timeIntervalSince1970
        
        DManager.sharedInstance?.createData(
            entityName:DEntry.entityName)
        { [weak self] (data) in
            
            guard
            
                let entry:DEntry = data as? DEntry
            
            else
            {
                return
            }
            
            entry.wordId = wordId
            entry.word = word
            entry.language = languageRaw
            entry.region = region
            entry.timestamp = timestamp
            
            self?.addToFavorites(entry)
            
            DManager.sharedInstance?.save()
        }
    }
    
    func asyncUnFavorite(
        wordId:String,
        languageRaw:Int16)
    {
        guard
            
            let favorites:[DEntry] = self.favorites?.array as? [DEntry]
            
        else
        {
            return
        }
        
        for favorite:DEntry in favorites
        {
            if favorite.wordId == wordId
            {
                if favorite.language == languageRaw
                {
                    self.removeFromFavorites(favorite)
                    
                    break
                }
            }
        }
        
        DManager.sharedInstance?.save()
    }
    
    //MARK: public
    
    func addTtl()
    {
        ttl += 1
        DManager.sharedInstance?.save()
    }
    
    func currentLanguage() -> MLanguage
    {
        let language:MLanguage = MLanguage.language(
            rawValue:self.language)
        
        return language
    }
    
    func changeLanguage(language:MLanguage)
    {
        self.language = language.rawValue
        DManager.sharedInstance?.save()
    }
    
    func recentEntry(
        wordId:String,
        word:String,
        languageRaw:Int16,
        region:String?)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncRecentEntry(
            wordId:wordId,
            word:word,
            languageRaw:languageRaw,
            region:region)
        }
    }
    
    func isFavorited(wordId:String, languageRaw:Int16) -> Bool
    {
        guard
        
            let favorites:[DEntry] = self.favorites?.array as? [DEntry]
        
        else
        {
            return false
        }
        
        for favorite:DEntry in favorites
        {
            if favorite.wordId == wordId
            {
                if favorite.language == languageRaw
                {
                    return true
                }
            }
        }
        
        return false
    }
    
    func makeFavorite(
        wordId:String,
        word:String,
        languageRaw:Int16,
        region:String?)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncMakeFavorite(
                wordId:wordId,
                word:word,
                languageRaw:languageRaw,
                region:region)
        }
    }
    
    func unFavorite(
        wordId:String,
        languageRaw:Int16)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncUnFavorite(
                wordId:wordId,
                languageRaw:languageRaw)
        }
    }
    
    func timeFromLastSearch() -> TimeInterval
    {
        guard
        
            let lastSearch:DEntry = recent?.firstObject as? DEntry
        
        else
        {
            return DSettings.kWaitingTime
        }
        
        let now:TimeInterval = Date().timeIntervalSince1970
        let deltaTime:TimeInterval = now - lastSearch.timestamp
        
        return deltaTime
    }
}
