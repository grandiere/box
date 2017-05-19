import UIKit

class VLandingBar:UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CLanding!
    private weak var collectionView:VCollection!
    private let kBorderHeight:CGFloat = 1
    private let kBlurAlpha:CGFloat = 0.99
    private let kCellSize:CGFloat = 60
    private let kLogoHeight:CGFloat = 100
    private let kDeselectTime:TimeInterval = 0.3
    
    init(controller:CLanding)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.contentMode = UIViewContentMode.center
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "assetGenericLandingLogo")
        
        let blurContainer:UIView = UIView()
        blurContainer.isUserInteractionEnabled = false
        blurContainer.translatesAutoresizingMaskIntoConstraints = false
        blurContainer.clipsToBounds = true
        blurContainer.alpha = kBlurAlpha
        
        let blur:VBlur = VBlur.dark()
        
        let border:VBorder = VBorder(color:UIColor(white:1, alpha:0.2))
        
        let collectionView:VCollection = VCollection()
        collectionView.isScrollEnabled = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VLandingBarCell.self)
        self.collectionView = collectionView
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.scrollDirection = UICollectionViewScrollDirection.horizontal
            flow.itemSize = CGSize(width:kCellSize, height:kCellSize)
        }
        
        blurContainer.addSubview(blur)
        addSubview(blurContainer)
        addSubview(border)
        addSubview(imageView)
        addSubview(collectionView)
        
        NSLayoutConstraint.equals(
            view:blurContainer,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:blurContainer)
        
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:collectionView,
            toView:self)
        NSLayoutConstraint.height(
            view:collectionView,
            constant:kCellSize)
        NSLayoutConstraint.equalsHorizontal(
            view:collectionView,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self)
        NSLayoutConstraint.height(
            view:imageView,
            constant:kLogoHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:imageView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MLandingBarProtocol
    {
        let item:MLandingBarProtocol = controller.model.barItems[index.item]
        
        return item
    }
    
    //MARK: collectionView delegate
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.barItems.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MLandingBarProtocol = modelAtIndex(index:indexPath)
        let cell:VLandingBarCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VLandingBarCell.reusableIdentifier,
            for:indexPath) as! VLandingBarCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        collectionView.isUserInteractionEnabled = false
        let item:MLandingBarProtocol = modelAtIndex(index:indexPath)
        item.selected(controller:controller)
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kDeselectTime)
        { [weak collectionView] in
            
            collectionView?.selectItem(
                at:nil,
                animated:true,
                scrollPosition:UICollectionViewScrollPosition())
            collectionView?.isUserInteractionEnabled = true
        }
    }
}
