extends BasicEvent

enum Type {
	T1,
	T2,
}

var type : Type

func _init() -> void:
	event_name = &"EventName"
	
static func trigger(_t: Type) -> void:
	#var e := SeedBankEvent.new()
	#e.type = t
	
	#EventManager.trigger_event(e)
	pass
