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

@export var tasks = load("res://save/savedtasks.tres")

@export var current_action: String
@export var current_task: Dictionary:
	set(value):
		if value != {}:
			print("task assigned")
			current_task = value
			emit_signal("assign_done")
		elif current_task == {}:
			emit_signal("assign_task")
			
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
	set("current_task",tasks.assign_task())
	
func _on_assign_done():
	set("task_position",current_task.location)
	#saveTaskData()
	
func _on_task_completed():
	finished_task = true
	current_action = "None"
	current_task = {}
	
#func _update():
	#if current_task == {}:
		#emit_signal()
	

