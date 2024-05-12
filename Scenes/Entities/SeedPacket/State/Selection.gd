extends State

func enter() -> void:
	(owner as TextureButton).disabled = false
	($"../../Avatar" as TextureRect).visible = true
	($"../../Cost" as Label).visible = true
	super.enter()

func update(_delta: float) -> void:
	pass
	
func exit() -> void:
	super.exit()

