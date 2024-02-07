extends Node2D

@onready var _char = $"../Cat"
@onready var _typetext = $Type
@onready var _jobtext = $Job

# Called when the node enters the scene tree for the first time.
func _ready():
	_typetext.text = str(_char.stats.type)
	_jobtext.text = str(_char.stats.job)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

