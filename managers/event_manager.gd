extends Node

static var subscribers : Dictionary = {}

static func add_listener(event: BasicEvent) -> void:
	if not subscribers.has(event.event_name):
		var list : Array[BasicEvent] = []
		subscribers[event.event_name] = list

	var events := subscribers[event.event_name] as Array[BasicEvent]
	
	if not events.has(event):
		events.append(event)
	
static func trigger_event(e: BasicEvent) -> void:
	var events := subscribers.get(e.event_name, []) as Array[BasicEvent]
	for event in events:
		event.on_event.emit(e)
