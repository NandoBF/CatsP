extends PopupMenu

var building_menu = false
var screen_size
var menusize = 200

@onready var _map = $".."

enum MenuIds {
	blocks
}


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = _map.get_viewport_rect().size
	self.visible = false
	print(screen_size)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


