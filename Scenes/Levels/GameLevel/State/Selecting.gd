extends State

@onready var selecting_bg_player := $"../../SelectingBG" as AudioStreamPlayer

var seed_chooser_event := SeedChooserEvent.new()

func enter() -> void:
	print("Selecting Seed")
	seed_chooser_event.on_event.connect(_seed_chooser_event)
	EventManager.add_listener(seed_chooser_event)
	
	selecting_bg_player.play()
	
	super.enter()

func update(_delta: float) -> void:
	pass
	
func exit() -> void:
	super.exit()
		
func _seed_chooser_event(e: SeedChooserEvent) -> void:
	if e.type == SeedChooserEvent.Type.SELECTION_COMPLETE:
		emit_signal("finished", "SelectionComplete")

