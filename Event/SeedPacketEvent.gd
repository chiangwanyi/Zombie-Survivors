class_name SeedPacketEvent extends BasicEvent

enum Type {
	BACK_TO_SEED_CHOOSER,	# Selecting 状态时，在 SeedBank 中点击 Seed
	ADD_TO_SEED_BANK,		# Selecting 状态时，在 SeedChooser 中点击 Seed
	DRAG_ON,				# 开始拖拽 Seed
	DRAG_OFF,				# 结束拖拽 Seed
}

var type: Type
var seed_name: StringName

func _init() -> void:
	event_name = &"SeedPacketEvent"
	
static func trigger(t: Type, sn: StringName) -> void:
	var e := SeedPacketEvent.new()
	e.type = t
	e.seed_name = sn
	
	EventManager.trigger_event(e)
