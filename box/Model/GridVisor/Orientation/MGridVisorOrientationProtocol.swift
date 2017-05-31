import Foundation

protocol MGridVisorOrientationProtocol
{
    func itemPosition(
        userHeading:Float,
        moveVertical:Float,
        itemHeading:Float) -> MetalPosition
}
