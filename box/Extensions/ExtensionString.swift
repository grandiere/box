import Foundation

extension String
{
    func capitalizedFirstLetter() -> String
    {
        let count:Int = characters.count
        
        if count < 1
        {
            return self
        }
        else if count == 1
        {
            return uppercased()
        }
        
        let firstLetter:String = String(self[startIndex]).uppercased()
        let remainRange:Range = Range(uncheckedBounds:(
            lower:index(startIndex, offsetBy:1),
            upper:index(startIndex, offsetBy:count)))
        let remain:String = self[remainRange].lowercased()
        let newString:String = "\(firstLetter)\(remain)"
        
        return newString
    }
}
