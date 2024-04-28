extends Node2D

# 僵尸和植物的scene资源缓存
var entity_resources : Dictionary = {}

var debug_spawn_mode := SpawnEvent.ItemType.ZOMBIE

var spawn_event := SpawnEvent.new()

func _ready() -> void:
	spawn_event.on_event.connect(self.spawn_item)
	
	EventManager.add_listener(spawn_event)

func _process(delta: float) -> void:
	pass
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed == false:
			return
			
		var mouse_pos := get_global_mouse_position()
		
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				match debug_spawn_mode:
					SpawnEvent.ItemType.ZOMBIE:
						SpawnEvent.trigger(SpawnEvent.ItemType.ZOMBIE, "zombie", mouse_pos)
					SpawnEvent.ItemType.PLANT:
						SpawnEvent.trigger(SpawnEvent.ItemType.PLANT, "pea_shooter_single", mouse_pos)
				
	
func on_game_paused() -> void:
	print("game is pause")
	
func spawn_item(e: SpawnEvent) -> void:
	match e.item_type:
		SpawnEvent.ItemType.PLANT:
			spawn_plant(e.item_type_name, e.spawn_pos)
		SpawnEvent.ItemType.ZOMBIE:
			spawn_zombie(e.item_type_name, e.spawn_pos)
		
func spawn_zombie(zombie_type: String, spawn_pos: Vector2) -> void:
	if not entity_resources.has(zombie_type):
		var res = load("res://entities/zombies/%s/%s.tscn" % [zombie_type, zombie_type])
		if res == null:
			printerr("未找到僵尸:%s" % zombie_type)
			return
		else:
			entity_resources[zombie_type] = res
			
	var entity := (entity_resources[zombie_type] as PackedScene).instantiate() as Zombie
	entity.position = spawn_pos
	add_child(entity)
	
func spawn_plant(plant_type: String, spawn_pos: Vector2) -> void:
	if not entity_resources.has(plant_type):
		var res = load("res://entities/plants/%s/%s.tscn" % [plant_type, plant_type])
		if res == null:
			printerr("未找到植物:%s" % plant_type)
			return
		else:
			entity_resources[plant_type] = res
			
	var entity := (entity_resources[plant_type] as PackedScene).instantiate() as Plant
	entity.position = spawn_pos
	add_child(entity)
	GameManager.plants.append(entity)

func _on_debug_spawn_zombie_pressed() -> void:
	debug_spawn_mode = SpawnEvent.ItemType.ZOMBIE


func _on_debug_spawn_plant_pressed() -> void:
	debug_spawn_mode = SpawnEvent.ItemType.PLANT
