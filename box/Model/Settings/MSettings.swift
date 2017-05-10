import Foundation

class MSettings
{
    let items:[MSettingsProtocol]
    
    init()
    {
        let itemDistance:MSettingsDistance = MSettingsDistance()
        let itemShare:MSettingsShare = MSettingsShare()
        let itemReview:MSettingsReview = MSettingsReview()
        
        items = [
            itemDistance,
            itemShare,
            itemReview]
    }
}
