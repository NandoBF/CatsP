extends Node2D

@onready var _blockslist = $Blocks/BlocksList
@onready var _nav_region = $"../NavigationRegion2D"

var building_menu = false
var proDict = {
	"Dirt" = Vector2i(0,0)
}


# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false
	_blockslist.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_blocks_pressed():
	_blockslist.visible = not _blockslist.visible

func _unhandled_input(event):
	#passar para map
	if event is InputEventKey:
		if Input.is_key_pressed(KEY_B):
			building_menu = not building_menu
			self.visible = building_menu
			#_menu_bar.set_menu_disabled(0,not _menu_bar.is_menu_disabled(0))
			
	if event is InputEventMouse and building_menu:
		get_viewport().set_input_as_handled()


func _on_blocks_list_item_selected(index):
	match index:
		0:
			_nav_region.addTile(proDict.Dirt)
		1:
			print("1")
