extends State

@onready var level_grasswalk_bg := $"../../LevelGrasswalkBG" as AudioStreamPlayer

func enter() -> void:
	print("Playing")
	# 通知 SeedBank 修改 SeedPacket 动作
	GameEvent.trigger(GameEvent.Type.Playing)
	
	level_grasswalk_bg.play()
	super.enter()

func update(_delta: float) -> void:
	pass
	
func exit() -> void:
	super.exit()
