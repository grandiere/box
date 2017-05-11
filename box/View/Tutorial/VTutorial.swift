import UIKit

class VTutorial:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CTutorial!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CTutorial
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: collectionView delegate
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let cell:VTutorialCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: <#T##String#>, for: <#T##IndexPath#>)
    }
}
