import UIKit

class VLanding:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CLanding!
    private weak var viewBar:VLandingBar!
    private weak var collectionView:VCollection!
    private weak var spinner:VSpinner?
    private let kBarHeight:CGFloat = 60
    private let kInterItem:CGFloat = 1
    private let kCollectionBottom:CGFloat = 20
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CLanding
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let viewBar:VLandingBar = VLandingBar(
            controller:self.controller)
        viewBar.isHidden = true
        self.viewBar = viewBar
        
        let collectionView:VCollection = VCollection()
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView = collectionView
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.minimumLineSpacing = kInterItem
            flow.minimumInteritemSpacing = kInterItem
            flow.sectionInset = UIEdgeInsets(
                top:0,
                left:0,
                bottom:0,
                right:kCollectionBottom)
        }
        
        addSubview(collectionView)
        addSubview(viewBar)
        addSubview(spinner)
        
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
    
    deinit
    {
        spinner?.stopAnimating()
    }
    
    //MARK: actions
    
    func actionScanner(sender button:UIButton)
    {
        controller.openScanner()
    }
    
    //MARK: public
    
    func sessionLoaded()
    {
        spinner?.stopAnimating()
        spinner?.removeFromSuperview()
    }
    
    //MARK: collectionView delegate
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        
    }
}
