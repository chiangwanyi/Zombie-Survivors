extends Node

static var subscribers : Dictionary = {}

func add_listener(event: BasicEvent) -> void:
	if not subscribers.has(event.event_name):
		var list : Array[BasicEvent] = []
		subscribers[event.event_name] = list

	var events := subscribers[event.event_name] as Array[BasicEvent]
	
	if not events.has(event):
		events.append(event)
	
func trigger_event(e: BasicEvent) -> void:
	var events = subscribers.get(e.event_name, []) as Array
	if events.is_empty():
		return
	for event in events as Array[BasicEvent]:
		event.on_event.emit(e)
