extends Node2D

@onready var tile_map = $NavigationRegion2D/TileMap
@onready var _nav_region = $NavigationRegion2D
var tile_map_layer = 0 
var tile_map_cell_position = Vector2i(0,0) 


# Called when the node enters the scene tree for the first time.
func _ready():
	var tile_map_cell_source_id = tile_map.get_cell_source_id(tile_map_layer, tile_map_cell_position); 
	var tile_map_cell_atlas_coords = tile_map.get_cell_atlas_coords(tile_map_layer, tile_map_cell_position) 
	var tile_map_cell_alternative = tile_map.get_cell_alternative_tile(tile_map_layer, tile_map_cell_position) 
	var new_tile_map_cell_position = Vector2i(9,5)
	tile_map.set_cell(tile_map_layer, new_tile_map_cell_position, tile_map_cell_source_id, tile_map_cell_atlas_coords, tile_map_cell_alternative)
	_nav_region.bake_navigation_polygon()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print (tile_map.local_to_map(get_global_mouse_position()))
	pass
