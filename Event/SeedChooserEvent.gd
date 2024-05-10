class_name SeedChooserEvent extends BasicEvent

enum Type {
	SELECTION_COMPLETE,	# 种子选择完毕
}

var type : Type

func _init() -> void:
	event_name = &"SeedChooserEvent"
	
static func trigger(t: Type) -> void:
	var e := SeedChooserEvent.new()
	e.type = t
	
	EventManager.trigger_event(e)
