// Copyright Team Seedling ©

import UIKit

class TaskSectionCell: UITableViewCell
{
    // Title
    // Add button
    
    var taskSection: TaskSection?
    
    let button: UIButton
    let label: UILabel
    let visualEffectView: UIVisualEffectView
    let stackView: UIStackView
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        label = Self.makeLabel()
        visualEffectView = Self.makeVisualEffectView()
        stackView = Self.makeStackView()
        button = Self.makeButton()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        taskSection = nil
        button.removeTarget(nil, action: nil, for: .touchUpInside)
        label.text = ""
    }
    
    // MARK: - Factory
    
    class func makeButton() -> UIButton
    {
        let button = UIButton(type: .contactAdd)
        button.tintColor = .type(.orange)
        return button
    }
    
    class func makeLabel() -> UILabel
    {
        return UILabel(style: .sectionHeader)
    }
    
    private class func makeBlurEffect() -> UIBlurEffect
    {
        let style = UIBlurEffect.Style.regular
        return UIBlurEffect(style: style)
    }
    
    class func makeVisualEffectView() -> UIVisualEffectView
    {
        let blurEffect = makeBlurEffect()
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        return visualEffectView
    }
    
    class func makeStackView() -> UIStackView
    {
        return UIStackView()
    }
    
    // MARK: - Configuration
    
    func configure(with taskSection: TaskSection)
    {
        self.taskSection = taskSection
        configureLabel(content: taskSection.title ?? "")
        configureButton(title: taskSection.title ?? "")
        configureStackView()
        configureVisualEffectView()
        configureView()
    }
    
    func configureLabel(content: String)
    {
        label.text = content
        label.textAlignment = .center
    }
    
    func configureButton(title: String)
    {
        button.addTarget(
            self,
            action: #selector(self.didTouchUpInsideButton(_:)),
            for: .touchUpInside)
        button.widthAnchor.constraint(equalTo: button.heightAnchor).isActive = true
        button.accessibilityLabel = title
        button.accessibilityIdentifier = title // TODO: Check accesibility works properly
    }
    
    func configureStackView()
    {
        let horizontalStackView = UIStackView()
        
        let leftSpacer = Spacer()
        let rightSpacer = Spacer()
        
        let buttonStack = UIStackView()
        buttonStack.addArrangedSubview(Spacer(width: 10))
        buttonStack.addArrangedSubview(button)
        buttonStack.addArrangedSubview(Spacer(width: 10))
        rightSpacer.embed(view: buttonStack)
        
        horizontalStackView.addArrangedSubview(leftSpacer)
        horizontalStackView.addArrangedSubview(label)
        horizontalStackView.addArrangedSubview(rightSpacer)
        
        leftSpacer.widthAnchor.constraint(equalTo: rightSpacer.widthAnchor).isActive = true
        
        stackView.axis = .vertical
        
        stackView.addArrangedSubview(Spacer(height: 5))
        stackView.addArrangedSubview(horizontalStackView)
        stackView.addArrangedSubview(Spacer(height: 5))
    }
    
    func configureVisualEffectView()
    {
        visualEffectView.contentView.embed(view: stackView)
    }
    
    func configureView()
    {
        let verticalStack = UIStackView(arrangedSubviews: [visualEffectView, Spacer(height: 10)])
        verticalStack.axis = .vertical
        embed(view: verticalStack)
    }
    
    // MARK: - Selectors
    
    @objc func didTouchUpInsideButton(_ sender: UIButton)
    {
        let section = sender.tag - 1
        print("Add button was pressed")
        // TODO: Do something
//        switch section
//        {
//        case 0:
//            tableView?.performBatchUpdates({
//                let priorityCount = dayProvider?.day.prioritiesArray.count
//                let priority = Task.make(content: "", in: database!.context)
//                dayProvider?.day.addToPriorities(priority)
//                let indexPath = IndexPath(item: priorityCount ?? 0, section: 0)
//                tableView?.insertRows(at: [indexPath], with: .automatic)
//                editingIndexPath = indexPath
//            }, completion: { _ in
//                self.database?.save()
//            })
//        case 1:
//            tableView?.performBatchUpdates({
//                let todoCount = dayProvider?.day.todosArray.count // It matters when we create this variable
//                let todo = Task.make(content: "", in: database!.context)
//                dayProvider?.day.addToTodos(todo)
//                let indexPath = IndexPath(item: todoCount ?? 0, section: 1)
//                tableView?.insertRows(at: [indexPath], with: .automatic)
//                // Start editing the last row...
//                editingIndexPath = indexPath
//            }, completion: { _ in
//                self.database?.save()
//            })
//        default:
//            break
//        }
    }
}
