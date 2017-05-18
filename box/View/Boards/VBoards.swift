import UIKit

class VBoards:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CBoards!
    private weak var viewBar:VBoardsBar!
    private weak var collectionView:VCollection!
    private weak var spinner:VSpinner!
    private let kBarHeight:CGFloat = 130
    private let kCollectionBottom:CGFloat = 20
    private let kCellHeight:CGFloat = 50
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CBoards
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let viewBar:VBoardsBar = VBoardsBar(
            controller:self.controller)
        self.viewBar = viewBar
        
        let collectionView:VCollection = VCollection()
        collectionView.isHidden = true
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VBoardsCellScore.self)
        collectionView.registerCell(cell:VBoardsCellKills.self)
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
        addSubview(collectionView)
        addSubview(viewBar)
        
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
        
        NSLayoutConstraint.equals(
            view:collectionView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    deinit
    {
        spinner.stopAnimating()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MBoardsItem
    {
        let item:MBoardsItem = controller.model.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func startLoading()
    {
        spinner.startAnimating()
        collectionView.isHidden = true
        viewBar.viewSelector.isUserInteractionEnabled = false
    }
    
    func stopLoading()
    {
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData()
        viewBar.viewSelector.isUserInteractionEnabled = true
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = bounds.maxX
        let size:CGSize = CGSize(width:width, height:kCellHeight)
        
        return size
    }
    
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
        let item:MBoardsItem = modelAtIndex(index:indexPath)
        let cell:VBoardsCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VBoardsCell.reusableIdentifier,
            for:indexPath) as! VBoardsCell
        cell.config(item:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldSelectItemAt indexPath:IndexPath) -> Bool
    {
        return false
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldHighlightItemAt indexPath:IndexPath) -> Bool
    {
        return false
    }
}
