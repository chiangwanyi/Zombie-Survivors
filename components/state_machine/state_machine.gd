@icon("res://components/state_machine/state_machine.svg")
class_name StateMachine extends Node
# 通用状态机的基本接口。
# 它处理初始化、设置机器是否处于活动状态
# 将 _physical_process、_input 调用委托给状态节点，
# 并更改 current/active state

signal state_changed(current_state)

@export var start_state: State

var states_map : Dictionary = {}
var states_stack : Array[State] = []
var current_state : State = null


var _active = false:
	set(value):
		_active = value
		set_active(value)


func _enter_tree() -> void:
	if start_state == null:
		start_state = get_child(0) as State
	for child: State in get_children():
		var err = child.finished.connect(self._change_state)
		if err:
			printerr(err)

func start():
	initialize(start_state)

func initialize(initial_state: State):
	_active = true
	states_stack.push_front(initial_state)
	current_state = states_stack[0]
	current_state.enter()


func set_active(value: bool):
	set_physics_process(value)
	set_process_input(value)
	if not _active:
		states_stack = []
		current_state = null


func _unhandled_input(event: InputEvent) -> void:
	current_state.handle_input(event)


func  _physics_process(delta: float) -> void:
	current_state.update(delta)


func _on_animation_finished(anim_name: String):
	if not _active:
		return
	current_state._on_animation_finished(anim_name)


func _change_state(state_name: StringName) -> void:
	if not _active:
		return
	current_state.exit()

	if state_name == &"previous":
		states_stack.pop_front()
	else:
		states_stack[0] = states_map[state_name]

	current_state = states_stack[0]
	emit_signal("state_changed", current_state)

	if state_name != &"previous":
		current_state.enter()
