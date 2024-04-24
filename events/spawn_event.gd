class_name SpawnEvent extends BasicEvent

enum ItemType {PLANT, ZOMBIE}

# 生成物品的类型（植物、僵尸）
var item_type: ItemType
# 生成物品的名称（豌豆射手、普通僵尸、路障僵尸）
var item_type_name: String
# 生成的位置（全局坐标）
var spawn_pos : Vector2

func _init() -> void:
	event_name = &"SpawnEvent"
	
static func trigger(type: ItemType, name: String, pos: Vector2) -> void:
	var e := SpawnEvent.new()
	e.item_type = type
	e.item_type_name = name
	e.spawn_pos = pos
	
	EventManager.trigger_event(e)
