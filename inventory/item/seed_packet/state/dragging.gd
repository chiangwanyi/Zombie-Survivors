extends State

var body: SeedPacketItem

func _ready() -> void:
    pass

func enter() -> void:
    print("enter dragging")
    body = owner as SeedPacketItem
    body.modulate = Color(0.75, 0.75, 0.75)
    # SeedPacket 当前状态为拖拽时，隐藏 SeedBank 面板
    get_tree().call_group("seed_bank", "hide_panel")

func update(_delta: float) -> void:
    pass
    
func exit() -> void:
    pass

func _exit_tree() -> void:
    pass

