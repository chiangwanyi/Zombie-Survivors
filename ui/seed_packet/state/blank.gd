extends State
# 卡片空白状态

func enter() -> void:
    (owner as TextureButton).disabled = true
    ($"../../Avatar" as TextureRect).visible = false
    ($"../../Cost" as Label).visible = false
    ($"../../CoolDownProgress" as TextureProgressBar).visible = false
    super.enter()

func update(_delta: float) -> void:
    pass
    
func exit() -> void:
    super.exit()

