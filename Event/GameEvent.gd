class_name GameEvent extends BasicEvent

enum Type {
	#PlayReady,
	Playing,
}

var type : Type

func _init() -> void:
	event_name = &"GameEvent"
	
static func trigger(t: Type) -> void:
	var e := GameEvent.new()
	e.type = t
	
	EventManager.trigger_event(e)
