extends Resource
class_name CharacterTasks

signal assigned_task(task: Dictionary)
signal task_completed()
signal location_reached()

@export var current_action: String
@export var current_task: Dictionary:
	set(value):
		if task_list.tasks == []:
			current_task = {}
		else:
			current_task = task_list["tasks"][0]
			emit_signal("assigned_task", current_task)
			task_list.tasks.remove_at(0)
			
@export var task_list: Dictionary
var finished_task: bool:
	set(value):
		if current_task == {}:
			finished_task = true
			
var task_position: Vector2:
	set(value):
		if current_task != {}:
			task_position = current_task.location
		else:
			task_position = Vector2(40,190)
var task_reached: bool:
	get:
		if task_reached:
			emit_signal("location_reached")
			return true
		else:
			return false
var id = 0

func _init():
	assigned_task.connect(_on_assigned_task)
	task_completed.connect(_on_task_completed)
	task_list = { "tasks":
		[ {"id": id,"type": "Farming", "prio": 1, "location": Vector2(200,900)}
		, {"id": id + 1, "type": "Moving", "prio": 2, "localization": Vector2(3,15)}
		
		]
	}
func _ready():
	task_position


func _on_assigned_task(task):
	finished_task = false
	task_position = task.location
	
func _on_task_completed():
	finished_task = true
	current_action = "None"
	
	
