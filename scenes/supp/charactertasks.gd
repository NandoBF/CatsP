extends Resource
class_name CharacterTasks

signal assign_task()
signal assign_done()
signal task_completed()
signal location_reached()

#used only for debugging
var saved_tasksPersisent = { 
"tasks": [{
"id": 0,
"location": Vector2i(2, 9),
"prio": 1,
"type": "Farming"
}, {
"id": 1,
"location": Vector2i(3, 15),
"prio": 2,
"type": "Moving"
}]
}

static var taskfile = "res://save/savedtasks.tres"
@export var current_action: String
@export var current_task: Dictionary:
	set(value):
		print(value)
		if value != {}:
			print("task assigned")
			current_task = task_list.tasks[0]
			emit_signal("assign_done")
		elif current_task == {}:
			emit_signal("assign_task")
			
@export var task_list: Dictionary
var finished_task: bool:
	set(value):
		if current_task == {}:
			finished_task = true
			
var task_position: Vector2i:
	set(value):
		if current_task != {}:
			task_position = value
		else:
			task_position = Vector2i(100,100)

var task_reached: bool:
	get:
		if task_reached:
			emit_signal("location_reached")
			return true
		else:
			return false
			
var id = 0
var can_use_file: bool

func _init():
	task_position = Vector2i(100,100) # tirar isto para mexer
	assign_task.connect(_on_assign_task)
	assign_done.connect(_on_assign_done)
	task_completed.connect(_on_task_completed)
	#saveTaskData()

func _ready():
	pass #does nothing
	

#Function that assigns a task to a character
func _on_assign_task():
	finished_task = false
	loadTaskData()
	set("current_task",task_list.tasks[0])
	
func _on_assign_done():
	task_list.tasks.remove_at(0)
	set("task_position",current_task.location)
	saveTaskData()
	
func _on_task_completed():
	finished_task = true
	current_action = "None"
	
	
func saveTaskData():
	var file = FileAccess.open(taskfile, FileAccess.WRITE)
	var saved_tasks:SavedTasks = SavedTasks.new()
	#print(saved_tasks)
	saved_tasks.saved_tasks = task_list
	ResourceSaver.save(saved_tasks,taskfile)
	file.close()
	
func loadTaskData():
	var file = FileAccess.open(taskfile, FileAccess.READ)
	var saved_tasks:SavedTasks = load(taskfile) as SavedTasks
	task_list = saved_tasks.saved_tasks
	file.close()


