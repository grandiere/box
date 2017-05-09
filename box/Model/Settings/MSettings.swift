import Foundation

class MSettings
{
    let items:[MSettingsProtocol]
    
    init()
    {
        let itemDistance:MSettingsDistance = MSettingsDistance()
        
        items = [
            itemDistance]
    }
}
