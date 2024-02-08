extends Node2D

@onready var _blockslist = $Blocks/BlocksList
@onready var _nav_region = $"../NavigationRegion2D"
@onready var _cam = $"../Player/CameraWorld"
@onready var tile_map = $"../NavigationRegion2D/TileMap"

var screen_size
var building_menu = false
var proDict = {
	"Dirt" = Vector2i(0,0),
	"Cave" = Vector2i(8,1)
}


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	self.visible = false
	_blockslist.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if building_menu:
		self.position = Vector2(_cam.get_screen_center_position().x - (_cam.get_viewport_rect().size.x / 2)/_cam.zoom.x,_cam.get_screen_center_position().y + (_cam.get_viewport_rect().size.y / 2)/_cam.zoom.y)
		self.scale = Vector2(1,1) / _cam.zoom

func _on_blocks_pressed():
	_blockslist.visible = not _blockslist.visible

func _unhandled_input(event):
	#passar para map
	if event is InputEventKey:
		if Input.is_key_pressed(KEY_B):
			building_menu = not building_menu
			self.visible = building_menu
			_nav_region.bake_navigation_polygon()
			if building_menu: Input.set_default_cursor_shape(Input.CURSOR_CROSS)
			else: Input.set_default_cursor_shape(Input.CURSOR_ARROW)
			#_menu_bar.set_menu_disabled(0,not _menu_bar.is_menu_disabled(0))
			

func _on_blocks_list_item_selected(index):
	match index:
		0:
			_nav_region.selectTile("Dirt")
		1:
			_nav_region.selectTile("Cave")
