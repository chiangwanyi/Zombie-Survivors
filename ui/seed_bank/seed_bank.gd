class_name SeedBank extends Control

@onready var seed_container := $SeedContainer
@onready var sun_label := $SunCount as Label

@onready var scene_seed_packet := preload("res://ui/seed_packet/seed_packet.tscn")

var game_event := GameEvent.new()
var seed_packet_event := SeedPacketEvent.new()
var seed_chooser_event := SeedChooserEvent.new()
var spawn_event := SpawnEvent.new()
var pick_event := PickEvent.new()

## 当前选择的 Seed 个数
var selected_seed_count := 0

## 当前 Sun 数
var sun: int:
	set(value):
		sun = value
		sun_label.text = str(value)

var is_game_playing := false

func _ready() -> void:
	game_event.on_event.connect(_on_game_event)
	seed_packet_event.on_event.connect(_on_event_seed_packet)
	seed_chooser_event.on_event.connect(_on_event_seed_chooser)
	spawn_event.on_event.connect(_on_event_spawn)
	pick_event.on_event.connect(_on_event_pick)
	
	EventManager.add_listener(game_event)
	EventManager.add_listener(seed_packet_event)
	EventManager.add_listener(seed_chooser_event)
	EventManager.add_listener(spawn_event)
	EventManager.add_listener(pick_event)

func init(init_sun: int) -> void:
	sun = init_sun

func _on_game_event(e: GameEvent) -> void:
	if e.type == GameEvent.Type.Playing:
		is_game_playing = true
		for sp: SeedPacket in seed_container.get_children():
			sp.state_machine.change_state("Ready")


func _on_event_seed_packet(e: SeedPacketEvent) -> void:
	# 将被选中的 SeedPacket 添加到 SeedBank 中
	if not is_game_playing and e.type == SeedPacketEvent.Type.ADD_TO_SEED_BANK:
		var packet := scene_seed_packet.instantiate() as SeedPacket
		packet.seed_bank = self
		packet.pressed.connect(_on_seed_packet_pressed.bind(packet))
		seed_container.add_child(packet)
		packet.set_info(e.seed_name)
		
		selected_seed_count += 1
	
	if not is_game_playing:
		_check_seed_bank()

func _on_event_seed_chooser(e: SeedChooserEvent) -> void:
	if e.type == SeedChooserEvent.Type.SELECTION_COMPLETE:
		is_game_playing = true
		for sp: SeedPacket in seed_container.get_children():
			sp.state_machine.change_state("Loading")

func _on_event_spawn(e: SpawnEvent) -> void:
	if e.type == SpawnEvent.Type.PLANT:
		sun -= e.spawn_cost
		
func _on_event_pick(e: PickEvent) -> void:
	if e.type == PickEvent.Type.Sun:
		sun += 100

func _on_seed_packet_pressed(packet: SeedPacket) -> void:
	if not is_game_playing:
		SeedPacketEvent.trigger(SeedPacketEvent.Type.BACK_TO_SEED_CHOOSER, packet.seed_name)
		
		packet.queue_free()
		selected_seed_count -= 1
		_check_seed_bank()
		


func _check_seed_bank() -> void:
	if selected_seed_count > 0:
		SeedBankEvent.trigger(SeedBankEvent.Type.HAS_SEED)
	elif selected_seed_count == 0:
		SeedBankEvent.trigger(SeedBankEvent.Type.NONE_SEED)
	elif selected_seed_count == GameManager.cfg_max_seed_bank_size:
		SeedBankEvent.trigger(SeedBankEvent.Type.FULL_SEED)