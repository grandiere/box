import UIKit

class MGridMapAnnotationAid:MGridMapAnnotation
{
    init(algo:MGridAlgoItem)
    {
        let image:UIImage = #imageLiteral(resourceName: "assetGenericMap")
        
        super.init(
            algo:algo,
            image:image)
    }
}
