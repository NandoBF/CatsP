extends NavigationRegion2D

@onready var tile_map = $TileMap
var building_menu = false
var tile_map_layer = 0 
var tile_map_cell_position = Vector2i(0,0) 


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
	pass

func addTile(pos):
	tile_map.set_cell(0,Vector2i(1,1),1,pos,0)
