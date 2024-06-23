@icon("res://_components/state_machine/state_machine.svg")
class_name StateMachine extends Node
# 通用状态机的基本接口。
# 它处理初始化、设置机器是否处于活动状态
# 将 _physical_process、_input 调用委托给状态节点，
# 并更改 current/active state

signal state_changed(current_state)

@export var start_state: State

## key 为 StateName, value 为 State
var states_map : Dictionary = {}
var states_stack : Array[State] = []
var current_state : State

var _active = false:
    set(value):
        _active = value
        set_active(value)

func _ready() -> void:
    _active = false
    if start_state == null:
        start_state = get_child(0) as State
    for child: State in get_children():
        states_map[child.name] = child
        var err = child.finished.connect(self.change_state)
        if err:
            printerr(err)

func set_active(value: bool):
    set_process(value)
    set_physics_process(value)
    set_process_input(value)
    if not _active:
        states_stack = []

func start():
    _initialize(start_state)

func _initialize(initial_state: State):
    states_stack.push_front(initial_state)
    current_state = states_stack[0]
    # 此处保证了 state 的 enter 执行完毕后才会启动 process
    current_state.enter()
    current_state.is_ready = true
    _active = true


func _unhandled_input(event: InputEvent) -> void:
    if not _active:
        return
    current_state.handle_input(event)


func _physics_process(delta: float) -> void:
    if not _active:
        return
    current_state.physics_update(delta)


func _process(delta: float) -> void:
    if not _active:
        return
    current_state.update(delta)


func change_state(state_name: StringName) -> void:
    set_process(false)
    set_physics_process(false)
    set_process_input(false)
    
    #if not _active:
        #printerr("change_state fail.")
        #return
    current_state.exit()
    current_state.is_ready = false
    if state_name == &"previous":
        states_stack.pop_front()
    else:
        states_stack[0] = states_map[state_name]

    current_state = states_stack[0]

    if state_name != &"previous":
        current_state.enter()
        current_state.is_ready = true
    _active = true
