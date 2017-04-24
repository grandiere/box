import UIKit
import CoreLocation

class CGridMap:CController, CLLocationManagerDelegate
{
    private(set) weak var modelAlgo:MGridAlgo!
    private weak var viewMap:VGridMap!
    
    init(modelAlgo:MGridAlgo)
    {
        self.modelAlgo = modelAlgo
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewMap:VGridMap = VGridMap(controller:self)
        self.viewMap = viewMap
        view = viewMap
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        parentController.viewParent.panRecognizer.isEnabled = false
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.askLocation()
        }
    }
    
    //MARK: private
    
    private func askLocation()
    {
        
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
}
