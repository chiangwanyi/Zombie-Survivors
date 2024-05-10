extends Node2D

@onready var state_machine := $StateMachine as StateMachine
@onready var seed_chooser := $HUD/SeedChooser as SeedChooser

var seed_packet_event := SeedPacketEvent.new()

## 当前正在准备种植的植物名称
var hold_seed_name : StringName
var hold_seed_sprite : Sprite2D

func _ready() -> void:
	seed_chooser.init_seed_chooser()
	seed_packet_event.on_event.connect(_on_seed_packet_event)
	
	EventManager.add_listener(seed_packet_event)
	state_machine.start()

func _on_seed_packet_event(e: SeedPacketEvent) -> void:
	# 只有游戏状态为 Playing 时，才处理 种子拖拽 事件
	if state_machine.current_state.name == &"Playing":
		if e.type == SeedPacketEvent.Type.DRAG_ON:
			if hold_seed_name.is_empty():
				hold_seed_name = e.seed_name
				
				var avatar := Sprite2D.new()
				avatar.texture = load("res://Assets/Images/Plants/%s.png" % e.seed_name)
				avatar.modulate = Color(Color.WHITE, 0.5)
				avatar.position = get_global_mouse_position()
				add_child(avatar)
				
				hold_seed_sprite = avatar
			else:
				if hold_seed_sprite != null:
					hold_seed_sprite.position = get_global_mouse_position()
		elif hold_seed_sprite != null and e.type == SeedPacketEvent.Type.DRAG_OFF:
			hold_seed_name = ""
			hold_seed_sprite.queue_free()
			
			_spawn_plant(e.seed_name, get_global_mouse_position())
			
func _spawn_plant(seed_name: StringName, pos: Vector2) ->void:
	var plant_scene := load("res://Scenes/Entities/Plants/%s/%s.tscn" % [seed_name, seed_name]) as PackedScene
	var plant = plant_scene.instantiate()
	plant.position = pos
	
	add_child(plant)
	
	GameManager.plants.append(plant as Plant)