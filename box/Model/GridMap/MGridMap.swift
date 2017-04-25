import Foundation

class MGridMap
{
    let annotations:[MGridMapAnnotation]
    
    init(modelAlgo:MGridAlgo)
    {
        var annotations:[MGridMapAnnotation] = []
        
        for algoItem:MGridAlgoItem in modelAlgo.items
        {
            let annotation:MGridMapAnnotation = MGridMapAnnotation(algo:algoItem)
            annotations.append(annotation)
        }
        
        self.annotations = annotations
    }
}
