class_name SeedChooser extends Control

@onready var seed_packet_container := $SeedPacketContainer

@onready var selection_complete_btn := $SelectionCompleteButton as TextureButton

var seed_packet_event := SeedPacketEvent.new()
var seed_bank_event := SeedBankEvent.new()

func _ready() -> void:
	seed_packet_event.on_event.connect(_on_seed_packet_event)
	seed_bank_event.on_event.connect(_on_seed_bank_event)
	
	EventManager.add_listener(seed_packet_event)
	EventManager.add_listener(seed_bank_event)

func init() -> void:
	for child in seed_packet_container.get_children():
		child.queue_free()
		
	for seed_name in GameManager.cfg_unlocked_seeds_name:
		var sp := GameManager.scene_seed_packet.instantiate() as SeedPacket
		sp.seed_info(seed_name)
		sp.seed_on()
		sp.pressed.connect(_on_seed_packet_pressed.bind(sp))
		seed_packet_container.add_child(sp)
	
	for i in range(GameManager.cfg_seeds.size() - GameManager.cfg_unlocked_seeds_name.size()):
		var sp := GameManager.scene_seed_packet.instantiate() as SeedPacket
		sp.seed_off()
		seed_packet_container.add_child(sp)
		
func _on_seed_packet_pressed(sp: SeedPacket) -> void:
	sp.visible = false
	
	SeedPacketEvent.trigger(SeedPacketEvent.Type.ADD_TO_SEED_BANK, sp.seed_name)

func _on_seed_packet_event(e: SeedPacketEvent) -> void:
	if e.type == SeedPacketEvent.Type.BACK_TO_SEED_CHOOSER:
		for child: SeedPacket in seed_packet_container.get_children():
			if child.seed_name == e.seed_name:
				child.visible = true
				break

func _on_seed_bank_event(e: SeedBankEvent) -> void:
	if e.type == SeedBankEvent.Type.HAS_SEED:
		selection_complete_btn.disabled = false
	elif e.type == SeedBankEvent.Type.NONE_SEED:
		selection_complete_btn.disabled = true
	
func _on_selection_complete_button_pressed() -> void:
	SeedChooserEvent.trigger(SeedChooserEvent.Type.SELECTION_COMPLETE)
