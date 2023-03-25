//
//  ExtrasController.swift
//  DailyPlanner
//
//  Created by Joshua Grant on 5/6/20.
//  Copyright © 2020 Joshua Grant. All rights reserved.
//

import UIKit

class ExtrasController: TabContentController
{
    // MARK: - Variables
    
    lazy var screenEdgeSwipeGesture: UIScreenEdgePanGestureRecognizer = {
        let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleScreenEdgeSwipe))
        gesture.edges = .right
        gesture.delegate = self
        return gesture
    }()
    
    // MARK: - Initialization
    
    override init?(dayProvider: DayProvider, database: Database)
    {
        super.init(dayProvider: dayProvider, database: database)
        configureDataSource()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.addGestureRecognizer(screenEdgeSwipeGesture)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        view.removeGestureRecognizer(screenEdgeSwipeGesture)
    }
    
    // MARK: - Factory
    
    override class func makeDelegate() -> TabContentDelegate
    {
        return ExtrasDelegate()
    }
    
    override class func makeDataSource(dayProvider: DayProvider) -> TabContentDataSource
    {
        return ExtrasDataSource(dayProvider: dayProvider)
    }
    
    override class func makeTableView() -> UITableView
    {
        return UITableView()
    }
    
    override class func makeTabBarItem() -> UITabBarItem {
        return UITabBarItem(
            title: SeedlingStrings.extras.localizedCapitalized,
            image: SeedlingAsset.extrasUnselected.image,
            selectedImage: SeedlingAsset.extrasSelected.image)
    }
    
    override class func makeCellClassIdentifiers() -> [CellClassIdentifier]
    {
        return [
            .init(cellClass: MealsCell.self, cellReuseIdentifier: "mealsCell"),
            .init(cellClass: WaterCell.self, cellReuseIdentifier: "waterCell"),
            .init(cellClass: PomodoroCell.self, cellReuseIdentifier: "pomodoroCell"),
            .init(cellClass: NotesCell.self, cellReuseIdentifier: "notesCell"),
            .init(cellClass: PrivacyPolicyCell.self, cellReuseIdentifier: "privacyPolicyCell")
        ]
    }
    
    // MARK: - Configuration
    
    override func configureDataSource()
    {
        (dataSource as? ExtrasDataSource)?.cellTextViewDelegate = self
        (dataSource as? ExtrasDataSource)?.database = database
    }
}

extension ExtrasController: CellTextViewDelegate
{
    func textViewDidBeginEditing(_ textView: UITextView, in cell: UITableViewCell)
    {
        
    }
    
    func textViewDidChange(_ textView: UITextView, in cell: UITableViewCell)
    {
        tableView.performBatchUpdates({
            UIView.animate(withDuration: 0.0) {
                cell.contentView.setNeedsLayout()
                cell.contentView.layoutIfNeeded()
            }
        }, completion: nil)
    }
    
    func textViewDidEndEditing(_ textView: UITextView, in cell: UITableViewCell)
    {
        
    }
    
    func textViewShouldReturn(_ textView: UITextView, in cell: UITableViewCell) -> Bool
    {
        //		textView.resignFirstResponder()
        //		return true
        return false // Allow the user to enter new lines
    }
    
    // MARK: - Actions
    
    @objc func handleScreenEdgeSwipe(_ sender: UIScreenEdgePanGestureRecognizer)
    {
        // TODO: Slide the view over and reveal the settings screen behind it...
        // Once they let go, switch over to the settings screen...
        switch sender.state
        {
        case .recognized:
            print("SCREEN EDGE SWIPE!!!")
        default:
            print("NON")
        }
    }
}

extension ExtrasController: UIGestureRecognizerDelegate
{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool
    {
        return true
    }
}
