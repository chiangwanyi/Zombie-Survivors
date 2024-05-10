class_name SpawnEvent extends BasicEvent

enum Type {
	PLANT,
	ZOMBIE,
}

var type : Type
var seed_name: StringName

func _init() -> void:
	event_name = &"SpawnEvent"
	
static func trigger(t: Type, name: StringName) -> void:
	var e := SpawnEvent.new()
	e.type = t
	e.seed_name = name
	
	EventManager.trigger_event(e)

