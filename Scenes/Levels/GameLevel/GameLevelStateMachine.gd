extends StateMachine

var seed_packet_event := SeedPacketEvent.new()
var seed_chooser_event := SeedChooserEvent.new()

func _ready() -> void:
	seed_packet_event.on_event.connect(_on_event_seed_packet)
	
	EventManager.add_listener(seed_packet_event)
	super._ready()
	
func _on_event_seed_packet(e: SeedPacketEvent) -> void:
	pass
	
