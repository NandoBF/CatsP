extends Resource
class_name characterstats

@export var type: int
@export var color: String
@export var job: int
var moving_speed: int
var building_speed
var farming_speed

func _init(_type = 0, _color = "DarkBlue", _job = 0):
	type = _type
	color = _color
	job = _job
	moving_speed = 75
