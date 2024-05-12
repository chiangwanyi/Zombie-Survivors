class_name SpawnEvent extends BasicEvent

enum Type {
	PLANT,
	ZOMBIE,
}

var type : Type
var seed_name: StringName
var spawn_cost: int

func _init() -> void:
	event_name = &"SpawnEvent"
	
static func trigger(t: Type, name: StringName, cost: int) -> void:
	var e := SpawnEvent.new()
	e.type = t
	e.seed_name = name
	e.spawn_cost = cost
	
	EventManager.trigger_event(e)

