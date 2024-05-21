extends State

var seed_chooser_event := SeedChooserEvent.new()

func _ready() -> void:
	seed_chooser_event.on_event.connect(_on_event_seed_chooser)
	EventManager.add_listener(seed_chooser_event)

func enter() -> void:
	print("Selecting start...")
	($"../../BgmSelecting" as AudioStreamPlayer).play()
	super.enter()

func update(_delta: float) -> void:
	pass
	
func exit() -> void:
	super.exit()

func _on_event_seed_chooser(e: SeedChooserEvent) -> void:
	if not is_active():
		return
	if e.type == SeedChooserEvent.Type.SELECTION_COMPLETE:
		emit_signal("finished", "SelectionComplete")
		
func _exit_tree() -> void:
	EventManager.remove_listener(seed_chooser_event)
