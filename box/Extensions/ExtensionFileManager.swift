import Foundation

extension FileManager
{
    open class var appDirectory:URL
    {
        get
        {
            let urls:[URL] = FileManager.default.urls(
                for:FileManager.SearchPathDirectory.documentDirectory,
                in:FileManager.SearchPathDomainMask.userDomainMask)
            let appDirectory:URL = urls.last!
            
            return appDirectory
        }
    }
}
