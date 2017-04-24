import UIKit

class MGridMapAnnotationBug:MGridMapAnnotation
{
    init(algo:MGridAlgoItem)
    {
        let image:UIImage = #imageLiteral(resourceName: "assetGenericMap")
        
        super.init(
            algo:algo,
            image:image)
    }
}
