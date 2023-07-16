// Copyright Team Seedling ©

import Foundation

class TaskManagerComponent
{
    /*
     Handle:
     - editing tasks
        * updating task content when textview change
        * saving task once finished editing - state change
        * changing states when going from no content to content
     - deleting tasks
        * empty tasks that we are no longer editing
        * swipe to delete actions, removing task from database
        * scroll deletes empty tasks without adding new ones
     - adding tasks
        * pressing return on previous task creates new task
        * pressing the add button while not currently editing a task
          or current task has content
     */
    
    enum State
    {
        case inactive
        //case creatingNewTask
        case editingEmptyTask(task: Task)
        case editingTaskWithContent(task: Task)
        //case deleting(task: Task)
    }
    
    var state: State = .inactive {
        didSet {
            print("NEW STATE: \(state)")
        }
    }
    var context: Context
    
    init(context: Context)
    {
        self.context = context
    }
    
    func textViewDidChange(content: String)
    {
        switch state {
        case .inactive:
            assertionFailure()
        case .editingEmptyTask(let task):
            task.content = content
            if !content.isEmpty
            {
                state = .editingTaskWithContent(task: task)
            }
        case .editingTaskWithContent(let task):
            task.content = content
            if content.isEmpty
            {
                state = .editingEmptyTask(task: task)
            }
        }
    }
    
    func textViewEndedEditing()
    {
        // TODO: Does this do anything?
    }
    
    func scrollViewEndedEditing()
    {
        switch state {
        case .inactive:
            break
        case .editingEmptyTask(let task):
            context.delete(task)
            saveContext()
            state = .inactive
        case .editingTaskWithContent:
            saveContext()
            state = .inactive
        }
    }
    
    func returnButtonPressed()
    {
        switch state {
        case .inactive:
            assertionFailure()
        case .editingEmptyTask(let task):
            context.delete(task)
            saveContext()
            state = .inactive
        case .editingTaskWithContent(let task):
            saveContext()
            let newTask = Task.make(in: context)
            newTask.sortIndex = Int32(task.dailyTaskSection?.tasks?.count ?? 0)
            task.dailyTaskSection?.addToTasks(newTask)
            state = .editingEmptyTask(task: newTask)
        }
    }
    
    func addButtonPressed(section: DailyTaskSection)
    {
        switch state {
        case .inactive:
            let newTask = Task.make(in: context)
            newTask.sortIndex = Int32(section.tasks?.count ?? 0)
            section.addToTasks(newTask)
            state = .editingEmptyTask(task: newTask)
        case .editingEmptyTask:
            break
        case .editingTaskWithContent:
            saveContext()
            let newTask = Task.make(in: context)
            newTask.sortIndex = Int32(section.tasks?.count ?? 0)
            section.addToTasks(newTask)
            state = .editingEmptyTask(task: newTask)
        }
    }
    
    func saveContext()
    {
        context.perform { [weak self] in
            try? self?.context.save()
        }
    }
}
