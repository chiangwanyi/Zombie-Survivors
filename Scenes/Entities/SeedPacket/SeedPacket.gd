class_name SeedPacket extends TextureButton

var seed_name: StringName
var cost: int
## Seed 是否可用
var is_available: bool
## Seed 是否处于冷却状态
var is_cooldown: bool

var dragging = false  # 用于跟踪是否正在拖拽

func seed_off() -> void:
	disabled = true
	($Avatar as TextureRect).visible = false
	($Cost as Label).visible = false
	
func seed_on() -> void:
	disabled = false
	($Avatar as TextureRect).visible = true
	($Cost as Label).visible = true
	
func seed_info(sn: StringName) -> void:
	seed_name = sn
	cost = int(GameManager.cfg_plants_dict[sn]["cost"])
	
	($Avatar as TextureRect).texture = load("res://Assets/Images/Plants/%s.png" % sn)
	($Cost as Label).text = str(cost)

func _process(_delta: float) -> void:
	pass

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				dragging = true  # 当左键按下时，开始拖拽
			else:
				dragging = false  # 当左键释放时，停止拖拽
				SeedPacketEvent.trigger(SeedPacketEvent.Type.DRAG_OFF, seed_name)
	elif event is InputEventMouseMotion:
		if dragging:
			SeedPacketEvent.trigger(SeedPacketEvent.Type.DRAG_ON, seed_name)
