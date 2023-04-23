// Copyright Team Seedling ©

import Foundation
import UIKit

class SectionHeaderButton: UIButton
{
    let section: TaskSection
    
    init(section: TaskSection)
    {
        self.section = section
        super.init(frame: .zero)
        setImage(.init(systemName: "plus.circle"), for: .normal)
        tintColor = .type(.orange)
        accessibilityLabel = section.title
        accessibilityIdentifier = "add.\(section.title ?? "")"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
