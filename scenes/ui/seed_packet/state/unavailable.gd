extends State

func enter() -> void:
	(owner as SeedPacket).modulate = Color8(150, 150, 150)
	super.enter()

func update(_delta: float) -> void:
	pass
	
func exit() -> void:
	super.exit()

