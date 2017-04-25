import UIKit
import CoreLocation

class VGridMapDetail:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private var model:MGridMapDetail?
    private weak var controller:CGridMap!
    private weak var collectionView:VCollection!
    private let kCornerRadius:CGFloat = 6
    private let kBorderWidth:CGFloat = 1
    private let kHeaderHeight:CGFloat = 95
    private let kCellHeight:CGFloat = 30
    
    init(controller:CGridMap)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = kCornerRadius
        layer.borderWidth = kBorderWidth
        layer.borderColor = UIColor(white:0, alpha:0.3).cgColor
        self.controller = controller
        
        let blur:VBlur = VBlur.light()
        
        let collectionView:VCollection = VCollection()
        collectionView.isScrollEnabled = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerHeader(header:VGridMapDetailHeader.self)
        collectionView.registerCell(cell:VGridMapDetailCell.self)
        self.collectionView = collectionView
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.headerReferenceSize = CGSize(width:0, height:kHeaderHeight)
        }
        
        addSubview(blur)
        addSubview(collectionView)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:collectionView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MGridMapDetailItem
    {
        let item:MGridMapDetailItem = model!.items[index.item]
        
        return item
    }
    
    private func updateModel(annotation:MGridMapAnnotation)
    {
        let userLocation:CLLocationCoordinate2D = controller.viewMap.viewRender.userLocation.coordinate
        let model:MGridMapDetail = MGridMapDetail(
            userLocation:userLocation,
            annotation:annotation)
        self.model = model
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.modelUpdated()
        }
    }
    
    private func modelUpdated()
    {
        collectionView.reloadData()
    }
    
    //MARK: public
    
    func updateAnnotation(annotation:MGridMapAnnotation)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.updateModel(annotation:annotation)
        }
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.maxX
        let size:CGSize = CGSize(width:width, height:kCellHeight)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        if model == nil
        {
            return 0
        }
        
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = model!.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, viewForSupplementaryElementOfKind kind:String, at indexPath:IndexPath) -> UICollectionReusableView
    {
        let header:VGridMapDetailHeader = collectionView.dequeueReusableSupplementaryView(
            ofKind:kind,
            withReuseIdentifier:
            VGridMapDetailHeader.reusableIdentifier,
            for:indexPath) as! VGridMapDetailHeader
        header.config(model:model!)
        
        return header
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MGridMapDetailItem = modelAtIndex(index:indexPath)
        let cell:VGridMapDetailCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VGridMapDetailCell.reusableIdentifier,
            for:indexPath) as! VGridMapDetailCell
        cell.config(model:item)
        
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
