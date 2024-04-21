class_name InventoryEvent extends BasicEvent

enum InventoryEventType { 
	Pick, Select, Click, Move, UseRequest,
	ItemUsed, EquipRequest, ItemEquipped, UnEquipRequest,
	ItemUnEquipped, Drop, Destroy, Error,
	Redraw, ContentChanged, InventoryOpens, InventoryCloseRequest,
	InventoryCloses, InventoryLoaded
}

var inventory_event_type: InventoryEventType

