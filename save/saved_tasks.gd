class_name SavedTasks
extends Resource

@export var task_list: Dictionary
@export var file_opened: bool
static var taskfile = "res://save/save.tres"

var current_id: int
var default_prio = 2

func _init():
	current_id = 10
	loadTaskData()
	#print(task_list)
	

func assign_task():
	return task_list.tasks.pop_front()

func _on_add_task(location):
	var tb_added_task = {
		"id" : current_id,
		"location" : location,
		"prio" : default_prio,
		"type" : "Farming"
	}
	current_id += 1
	print(tb_added_task)
	task_list.tasks.append(tb_added_task)

func saveTaskData():
	var file = FileAccess.open(taskfile, FileAccess.WRITE)
	var saved_tasks:Save = Save.new()
	saved_tasks.saved_tasks = task_list
	ResourceSaver.save(saved_tasks,taskfile)
	file.close()
	

func loadTaskData():
	var file = FileAccess.open(taskfile, FileAccess.READ)
	var saved_tasks:Save = load(taskfile) as Save
	task_list = saved_tasks.saved_tasks
	file.close()
