class_name SeedBankEvent extends BasicEvent

enum Type {
	HAS_SEED,	# SeedBank 中存在 Seed
	FULL_SEED,	# SeedBank 中 Seed 数量达到上限
	NONE_SEED,	# SeedBank 中不存在 Seed
}

var type : Type

func _init() -> void:
	event_name = &"SeedBankEvent"
	
static func trigger(t: Type) -> void:
	var e := SeedBankEvent.new()
	e.type = t
	
	EventManager.trigger_event(e)
