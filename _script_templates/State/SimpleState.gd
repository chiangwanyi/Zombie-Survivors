extends State

func _ready() -> void:
	pass

func enter() -> void:
	super.enter()

func update(_delta: float) -> void:
	if not is_active():
		return
	
func exit() -> void:
	super.exit()

func _exit_tree() -> void:
	pass
