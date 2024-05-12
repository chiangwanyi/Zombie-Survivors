class_name SeedBank extends Control

@onready var seed_container := $SeedContainer

var game_event := GameEvent.new()
var seed_packet_event := SeedPacketEvent.new()
#var seed_chooser_event := SeedChooserEvent.new()

## 当前选择的 Seed 个数
var selected_seed_count := 0
## 当前 Sun 数
var sun := 0

var is_game_playing := false

func _ready() -> void:
	game_event.on_event.connect(_on_game_event)
	seed_packet_event.on_event.connect(_on_seed_packet_event)
	#seed_chooser_event.on_event.connect(_on_seed_chooser_event)
	
	EventManager.add_listener(game_event)
	EventManager.add_listener(seed_packet_event)
	#EventManager.add_listener(seed_chooser_event)

func _on_game_event(e: GameEvent) -> void:
	if e.type == GameEvent.Type.Playing:
		is_game_playing = true

func _on_seed_packet_event(e: SeedPacketEvent) -> void:
	if not is_game_playing and e.type == SeedPacketEvent.Type.ADD_TO_SEED_BANK:
		var sp := GameManager.scene_seed_packet.instantiate() as SeedPacket
		sp.seed_info(e.seed_name)
		sp.seed_on()
		sp.pressed.connect(_on_seed_packet_pressed.bind(sp))
		
		seed_container.add_child(sp)
		selected_seed_count += 1
	
	if not is_game_playing:
		_check_seed_bank()

#func _on_seed_chooser_event(e: SeedChooserEvent) -> void:
	#pass
		
func _on_seed_packet_pressed(sp: SeedPacket) -> void:
	print("选择了 %s" % sp.seed_name)
	if not is_game_playing:
		SeedPacketEvent.trigger(SeedPacketEvent.Type.BACK_TO_SEED_CHOOSER, sp.seed_name)
		
		sp.queue_free()
		selected_seed_count -= 1
		_check_seed_bank()

func _check_seed_bank() -> void:
	if selected_seed_count > 0:
		SeedBankEvent.trigger(SeedBankEvent.Type.HAS_SEED)
	elif selected_seed_count == 0:
		SeedBankEvent.trigger(SeedBankEvent.Type.NONE_SEED)
	elif selected_seed_count == GameManager.cfg_max_seed_bank_size:
		SeedBankEvent.trigger(SeedBankEvent.Type.FULL_SEED)
