extends State

var body: SeedPacketItem

func _ready() -> void:
    pass

func enter() -> void:
    print("enter active")
    body = owner as SeedPacketItem
    body.modulate = Color(1, 1, 1, 1)
   
func exit() -> void:
    pass

func _exit_tree() -> void:
    pass

