import UIKit

class VGridHarvestBarCollect:UIButton
{
    private weak var controller:CGridHarvest!
    private weak var labelScore:UILabel!
    private weak var labelKills:UILabel!
    private weak var labelGet:UILabel!
    private weak var viewGet:UIView!
    private let kLabelsHeight:CGFloat = 26
    private let kTitlesHeigth:CGFloat = 18
    private let KBorderWidth:CGFloat = 1
    private let kCornerRadius:CGFloat = 6
    private let kGetWidth:CGFloat = 50
    private let kScoreMultiplier:CGFloat = 0.6
    private let kKillsMultiplier:CGFloat = 0.4
    
    init(controller:CGridHarvest)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = kCornerRadius
        layer.borderWidth = KBorderWidth
        isUserInteractionEnabled = false
        addTarget(
            self,
            action:#selector(actionCollect(sender:)),
            for:UIControlEvents.touchUpInside)
        self.controller = controller
        
        let viewGet:UIView = UIView()
        viewGet.translatesAutoresizingMaskIntoConstraints = false
        viewGet.isUserInteractionEnabled = false
        viewGet.clipsToBounds = true
        self.viewGet = viewGet
        
        let viewLabels:UIView = UIView()
        viewLabels.isUserInteractionEnabled = false
        viewLabels.translatesAutoresizingMaskIntoConstraints = false
        viewLabels.clipsToBounds = true
        viewLabels.backgroundColor = UIColor.clear
        
        let labelGet:UILabel = UILabel()
        labelGet.isUserInteractionEnabled = false
        labelGet.backgroundColor = UIColor.clear
        labelGet.translatesAutoresizingMaskIntoConstraints = false
        labelGet.textAlignment = NSTextAlignment.center
        labelGet.font = UIFont.bold(size:14)
        labelGet.text = NSLocalizedString("VGridHarvestBarCollect_labelGet", comment:"")
        self.labelGet = labelGet
        
        let labelScore:UILabel = UILabel()
        labelScore.translatesAutoresizingMaskIntoConstraints = false
        labelScore.isUserInteractionEnabled = false
        labelScore.backgroundColor = UIColor.clear
        labelScore.textAlignment = NSTextAlignment.center
        labelScore.font = UIFont.numeric(size:15)
        self.labelScore = labelScore

        let labelKills:UILabel = UILabel()
        labelKills.translatesAutoresizingMaskIntoConstraints = false
        labelKills.isUserInteractionEnabled = false
        labelKills.backgroundColor = UIColor.clear
        labelKills.textAlignment = NSTextAlignment.center
        labelKills.font = UIFont.numeric(size:15)
        self.labelKills = labelKills
        
        let labelScoreTitle:UILabel = UILabel()
        labelScoreTitle.isUserInteractionEnabled = false
        labelScoreTitle.translatesAutoresizingMaskIntoConstraints = false
        labelScoreTitle.backgroundColor = UIColor.clear
        labelScoreTitle.textAlignment = NSTextAlignment.center
        labelScoreTitle.font = UIFont.regular(size:10)
        labelScoreTitle.textColor = UIColor.white
        labelScoreTitle.text = NSLocalizedString("VGridHarvestBarCollect_labelScoreTitle", comment:"")
        
        let labelKillsTitle:UILabel = UILabel()
        labelKillsTitle.isUserInteractionEnabled = false
        labelKillsTitle.translatesAutoresizingMaskIntoConstraints = false
        labelKillsTitle.backgroundColor = UIColor.clear
        labelKillsTitle.textAlignment = NSTextAlignment.center
        labelKillsTitle.font = UIFont.regular(size:10)
        labelKillsTitle.textColor = UIColor.white
        labelKillsTitle.text = NSLocalizedString("VGridHarvestBarCollect_labelKillsTitle", comment:"")
        
        viewGet.addSubview(labelGet)
        viewLabels.addSubview(labelScore)
        viewLabels.addSubview(labelKills)
        viewLabels.addSubview(labelScoreTitle)
        viewLabels.addSubview(labelKillsTitle)
        addSubview(viewLabels)
        addSubview(viewGet)
        
        NSLayoutConstraint.equals(
            view:labelGet,
            toView:viewGet)
        
        NSLayoutConstraint.equalsVertical(
            view:viewLabels,
            toView:self)
        NSLayoutConstraint.rightToLeft(
            view:viewLabels,
            toView:viewGet)
        NSLayoutConstraint.leftToLeft(
            view:viewLabels,
            toView:self)
        
        NSLayoutConstraint.equalsVertical(
            view:viewGet,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:viewGet,
            toView:self)
        NSLayoutConstraint.width(
            view:viewGet,
            constant:kGetWidth)
        
        NSLayoutConstraint.topToTop(
            view:labelScore,
            toView:viewLabels)
        NSLayoutConstraint.height(
            view:labelScore,
            constant:kLabelsHeight)
        NSLayoutConstraint.width(
            view:labelScore,
            toView:viewLabels,
            multiplier:kScoreMultiplier)
        NSLayoutConstraint.rightToRight(
            view:labelScore,
            toView:viewLabels)
        
        NSLayoutConstraint.topToTop(
            view:labelKills,
            toView:viewLabels)
        NSLayoutConstraint.height(
            view:labelKills,
            constant:kLabelsHeight)
        NSLayoutConstraint.leftToLeft(
            view:labelKills,
            toView:viewLabels)
        NSLayoutConstraint.width(
            view:labelKills,
            toView:viewLabels,
            multiplier:kKillsMultiplier)
        
        NSLayoutConstraint.bottomToBottom(
            view:labelScoreTitle,
            toView:viewLabels)
        NSLayoutConstraint.height(
            view:labelScoreTitle,
            constant:kTitlesHeigth)
        NSLayoutConstraint.equalsHorizontal(
            view:labelScore,
            toView:labelScoreTitle)
        
        NSLayoutConstraint.bottomToBottom(
            view:labelKillsTitle,
            toView:viewLabels)
        NSLayoutConstraint.height(
            view:labelKillsTitle,
            constant:kTitlesHeigth)
        NSLayoutConstraint.equalsHorizontal(
            view:labelKillsTitle,
            toView:labelKills)
        
        hover()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override var isSelected:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    override var isHighlighted:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    //MARK: actions
    
    func actionCollect(sender button:UIButton)
    {
        button.isUserInteractionEnabled = false
        controller.collect()
    }
    
    //MARK: private
    
    private func hover()
    {
        if isUserInteractionEnabled
        {
            if isSelected || isHighlighted
            {
                layer.borderColor = UIColor.gridOrange.cgColor
                viewGet.backgroundColor = UIColor.gridOrange
                labelGet.textColor = UIColor.white
                labelScore.textColor = UIColor.gridOrange
                labelKills.textColor = UIColor.gridOrange
            }
            else
            {
                layer.borderColor = UIColor.gridBlue.cgColor
                viewGet.backgroundColor = UIColor.gridBlue
                labelGet.textColor = UIColor.black
                labelScore.textColor = UIColor.white
                labelKills.textColor = UIColor.white
            }
        }
        else
        {
            layer.borderColor = UIColor(white:1, alpha:0.2).cgColor
            viewGet.backgroundColor = UIColor(white:1, alpha:0.2)
            labelGet.textColor = UIColor(white:1, alpha:0.4)
            labelScore.textColor = UIColor(white:1, alpha:0.4)
            labelKills.textColor = UIColor(white:1, alpha:0.4)
        }
    }
    
    //MARK: public
    
    func displayHarvest()
    {
        labelScore.text = "\(controller.model.harvestScore)"
        labelKills.text = "\(controller.model.harvestKills)"
        
        if controller.model.harvestScore > 0
        {
            isUserInteractionEnabled = true
        }
        else
        {
            isUserInteractionEnabled = false
        }
        
        hover()
    }
}
