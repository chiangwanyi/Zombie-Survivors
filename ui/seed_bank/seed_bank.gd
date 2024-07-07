class_name SeedBank extends Control

@onready var seed_container := $SeedContainer
@onready var sun_label := $SunCount as Label
@onready var basic_inventory_ability: InventoryBasicAbility = $BasicInventoryAbility
@onready var state_machine: StateMachine = $StateMachine

## 当前 Sun 数
@export var sun: int = 0:
    set(value):
        if not is_inside_tree():
            await ready
        sun = value
        sun_label.text = str(sun)
        
## Seed 容量
var seed_capacity := 8

var seed_packet_item_scene := preload("res://inventory/item/seed_packet/seed_packet_item.tscn")

func _ready() -> void:
    reload()
    state_machine.start()

func reload() -> void:
    var cfg_level := GameManager.cfg_levels.get(GameManager.current_level_name) as Dictionary

    # 读取并初始化 sun 值
    sun = cfg_level.get("initial_sun")

    # 背包容量重载
    seed_capacity = cfg_level.get("initial_seed_capacity")

    # 加载初始【植物种子】列表
    var initial_seeds = cfg_level.get("initial_seeds") as Array

    var item_list = []
    for seed_name in initial_seeds:
        var item := seed_packet_item_scene.instantiate() as SeedPacketItem
        # item.item_name = seed_name
        item_list.append(item)

    # 背包重载
    #basic_inventory_ability.reload_with_items(seed_capacity, item_list)

func hide_panel() -> void:
    state_machine.change_state("Hide")

#var game_event := GameEvent.new()
#var seed_packet_event := SeedPacketEvent.new()
#var seed_chooser_event := SeedChooserEvent.new()
#var spawn_event := SpawnEvent.new()
#var pick_event := PickEvent.new()

### 当前选择的 Seed 个数
#var selected_seed_count := 0
#
#
#var is_game_playing := false


#
#func _on_game_event(e: GameEvent) -> void:
    #if e.type == GameEvent.Type.Playing:
        #is_game_playing = true
        #for sp: SeedPacket in seed_container.get_children():
            #sp.state_machine.change_state("Ready")
#
#
#func _on_event_seed_packet(e: SeedPacketEvent) -> void:
    ## 将被选中的 SeedPacket 添加到 SeedBank 中
    #if not is_game_playing and e.type == SeedPacketEvent.Type.ADD_TO_SEED_BANK:
        #var packet := seed_packet_item_scene.instantiate() as SeedPacket
        #packet.seed_bank = self
        #packet.pressed.connect(_on_seed_packet_pressed.bind(packet))
        #seed_container.add_child(packet)
        #packet.set_info(e.seed_name)
        #
        #selected_seed_count += 1
    #
    #if not is_game_playing:
        #_check_seed_bank()
#
#func _on_event_seed_chooser(e: SeedChooserEvent) -> void:
    #if e.type == SeedChooserEvent.Type.SELECTION_COMPLETE:
        #is_game_playing = true
        #for sp: SeedPacket in seed_container.get_children():
            #sp.state_machine.change_state("Loading")
#
#func _on_event_spawn(e: SpawnEvent) -> void:
    #if e.type == SpawnEvent.Type.PLANT:
        #sun -= e.spawn_cost
        #
#func _on_event_pick(e: PickEvent) -> void:
    #if e.type == PickEvent.Type.Sun:
        #sun += 100
#
#func _on_seed_packet_pressed(packet: SeedPacket) -> void:
    #if not is_game_playing:
        #SeedPacketEvent.trigger(SeedPacketEvent.Type.BACK_TO_SEED_CHOOSER, packet.seed_name)
        #
        #packet.queue_free()
        #selected_seed_count -= 1
        #_check_seed_bank()
        #
#
#
#func _check_seed_bank() -> void:
    #if selected_seed_count > 0:
        #SeedBankEvent.trigger(SeedBankEvent.Type.HAS_SEED)
    #elif selected_seed_count == 0:
        #SeedBankEvent.trigger(SeedBankEvent.Type.NONE_SEED)
    #elif selected_seed_count == GameManager.cfg_max_seed_bank_size:
        #SeedBankEvent.trigger(SeedBankEvent.Type.FULL_SEED)
