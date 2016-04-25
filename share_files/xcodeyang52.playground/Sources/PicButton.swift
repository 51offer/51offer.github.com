import Foundation
import UIKit

public class PicButton: UIButton {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initself()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initself()
    }
    
    private func initself() {
        if let path = NSBundle.mainBundle().pathForResource("swift-playground", ofType: "jpg") {
            let image = UIImage(contentsOfFile:path)
            setImage(image, forState: .Normal)
        }
        self.layer.cornerRadius = 10
    }
}