extends State

var seed_packet : SeedPacket

func enter() -> void:
    seed_packet = owner as SeedPacket
    
    super.enter()

func update(_delta: float) -> void:
    if seed_packet.seed_bank.sun >= seed_packet.cost:
        seed_packet.modulate = Color.WHITE
    else:
        emit_signal("finished", "Unavailable")
    
func exit() -> void:
    super.exit()

