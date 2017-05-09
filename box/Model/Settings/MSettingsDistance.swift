import UIKit

class MSettingsDistance:MSettingsProtocol
{
    private let kCellHeight:CGFloat = 100
    
    var reusableIdentifier:String
    {
        get
        {
            return VSettingsCellDistance.reusableIdentifier
        }
    }
    
    var cellHeight:CGFloat
    {
        get
        {
            return kCellHeight
        }
    }
}
