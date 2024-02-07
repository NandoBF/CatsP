extends NavigationRegion2D

@onready var tile_map = $TileMap
@onready var _BMenu = $"../BMenu"
@onready var _characters = $"../Characters"
var tile_map_layer = 0 
var tile_map_cell_position = Vector2i(0,0) 
var selectedTile = "None"
var forbidden_pos = []

var terrain = [Vector2i(0,0), Vector2i(0,1), Vector2i(0,2), Vector2i(1,0), Vector2i(1,1),
Vector2i(1,2), Vector2i(2,0), Vector2i(2,1), Vector2i(2,2)]
# Called when the node enters the scene tree for the first time.
func _ready():
	var tile_map_cell_source_id = tile_map.get_cell_source_id(tile_map_layer, tile_map_cell_position); 
	var tile_map_cell_atlas_coords = tile_map.get_cell_atlas_coords(tile_map_layer, tile_map_cell_position) 
	var tile_map_cell_alternative = tile_map.get_cell_alternative_tile(tile_map_layer, tile_map_cell_position) 
	var new_tile_map_cell_position = Vector2i(9,5)
	tile_map.set_cell(tile_map_layer, new_tile_map_cell_position, 1, tile_map_cell_atlas_coords, tile_map_cell_alternative)
	self.bake_navigation_polygon()
	#print (tile_map_cell_source_id)
	#print (tile_map.get_cell_source_id(tile_map_layer, Vector2i(0,0)))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	forbidden_pos = []
	for child in _characters.get_children():
		forbidden_pos.append(tile_map.local_to_map(child.get_node("./Cat").position))
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and selectedTile != "None":
		var ini_mouse = tile_map.local_to_map(get_global_mouse_position())
		if ini_mouse not in forbidden_pos:
			tile_map.set_cell(0,tile_map.local_to_map(get_global_mouse_position()),1,_BMenu.proDict[selectedTile],0)
			#tile_map.set_cells_terrain_connect(0,terrain,0,0,true)
	#print(forbidden_pos)


func selectTile(block):
	selectedTile = block
	#tile_map.set_cell(0,Vector2i(1,1),1,pos,0)

func _unhandled_input(event):
	
	if event is InputEventMouse and _BMenu.building_menu:
			get_viewport().set_input_as_handled()
		#if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and selectedTile != "None":
			#var ini_mouse = tile_map.local_to_map(get_global_mouse_position())
			#if ini_mouse not in forbidden_pos:
				#tile_map.set_cell(0,tile_map.local_to_map(get_global_mouse_position()),1,_BMenu.proDict[selectedTile],0)
				#tile_map.set_cells_terrain_connect(0,terrain,0,0,true)
		#get_viewport().set_input_as_handled()
		

