import ProjectDescription

let fileHeader = 
"""
Copyright Team Seedling ©
"""
let workspace = Workspace(
	name: "Seedling",
	projects: [.relativeToRoot("Seedling")],
    fileHeaderTemplate: .string(fileHeader))
