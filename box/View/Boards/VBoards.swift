import UIKit

class VBoards:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CBoards!
    private weak var collectionView:VCollection!
    private weak var spinner:VSpinner?
    private let kBarHeight:CGFloat = 50
    private let kCollectionBottom:CGFloat = 20
    private let kCellHeight:CGFloat = 60
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CBoards
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let viewBar:VBoardsBar = VBoardsBar(
            controller:self.controller)
        
        let collectionView:VCollection = VCollection()
        collectionView.isHidden = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VBoardsCell.self)
        self.collectionView = collectionView
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.sectionInset = UIEdgeInsets(
                top:kBarHeight,
                left:0,
                bottom:kCollectionBottom,
                right:0)
        }
        
        addSubview(spinner)
        addSubview(viewBar)
        addSubview(collectionView)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
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
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
    }
}
