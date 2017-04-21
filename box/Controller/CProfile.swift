import UIKit

class CProfile:CController
{
    private weak var viewProfile:VProfile!
    
    override func loadView()
    {
        let viewProfile:VProfile = VProfile(controller:self)
        self.viewProfile = viewProfile
        view = viewProfile
    }
}
