class_name SeedPacket extends TextureButton

@onready var state_machine := $StateMachine as StateMachine

var seed_name: StringName

## 所属 SeedBank
var seed_bank: SeedBank
## 种植所需阳光
var cost: int
## 种植后的冷却时间
var cooldown: int
## Seed 是否可用
var is_available: bool = false
## Seed 是否处于冷却状态
var is_cooldown: bool = false

var dragging = false  # 用于跟踪是否正在拖拽

func _ready() -> void:
	state_machine.start()
	
func set_info(n: StringName) -> void:
	seed_name = n
	cost = int(GameManager.cfg_seeds[n]["cost"])
	cooldown = int(GameManager.cfg_seeds[n]["cooldown"])
	
	($Avatar as TextureRect).texture = load("res://Assets/Images/Plants/%s.png" % n)
	($Cost as Label).text = str(cost)
	
	state_machine.change_state("Selection")

func _on_gui_input(event: InputEvent) -> void:
	if state_machine.current_state.name != &"Ready":
		return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				dragging = true  # 当左键按下时，开始拖拽
			else:
				dragging = false  # 当左键释放时，停止拖拽
				SeedPacketEvent.trigger(SeedPacketEvent.Type.DRAG_OFF, seed_name)
				state_machine.change_state("CoolDown")
	elif event is InputEventMouseMotion:
		if dragging:
			SeedPacketEvent.trigger(SeedPacketEvent.Type.DRAG_ON, seed_name)
