// Copyright Team Seedling ©

import UIKit

class TaskSectionCell: UITableViewCell
{
    // Title
    // Add button
    
    var taskSection: TaskSection?
    
    func configure(with taskSection: TaskSection)
    {
        self.taskSection = taskSection
    }
}
