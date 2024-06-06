class_name PickEvent extends BasicEvent

enum Type {
	Sun,
}

var type : Type

func _init() -> void:
	event_name = &"PickEvent"
	
static func trigger(t: Type) -> void:
	var e := PickEvent.new()
	e.type = t
	
	EventManager.trigger_event(e)
