import UIKit

class CGrid:CController
{
    let model:MGrid
    let modelAlgo:MGridAlgo
    private weak var viewGrid:VGrid!
    
    override init()
    {
        model = MGrid()
        modelAlgo = MGridAlgo()
        
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewGrid:VGrid = VGrid(controller:self)
        self.viewGrid = viewGrid
        view = viewGrid
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        if modelAlgo.items.count < 1
        {
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                self?.loadAlgo()
            }
        }
        else
        {
            modelAlgo.clearNearItems()
        }
    }
    
    //MARK: private
    
    private func loadAlgo()
    {
        modelAlgo.loadAlgo()
        algosLoaded()
    }
    
    private func algosLoaded()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewGrid.refresh()
        }
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func openMap()
    {
        let controllerMap:CGridMap = CGridMap(modelAlgo:modelAlgo)
        parentController.push(
            controller:controllerMap,
            horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func openVisor()
    {
        let controllerVisor:CGridVisor = CGridVisor(modelAlgo:modelAlgo)
        parentController.push(
            controller:controllerVisor,
            horizontal:CParent.TransitionHorizontal.fromRight)
    }
}
