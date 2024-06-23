class_name Weapon extends Node2D

var weapon_owner: Node2D

@export var projectile_spawn: Marker2D
@export var FORCE: float = 500.0

## 是否按下 trigger
var trigger_pressed: bool = false

func turn_on() -> void:
    trigger_pressed = true

func turn_off() -> void:
    trigger_pressed = false

func _process(_delta: float) -> void:
    queue_redraw()

func _draw() -> void:
    update_trajectory()
    _draw_line_global(global_position, get_global_mouse_position(), Color.RED)

func update_trajectory() -> void:
    var velocity : Vector2 = FORCE * get_forward_direction()
    var line_start := global_position
    var line_end : Vector2

    var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")
    var drag : float = ProjectSettings.get_setting("physics/2d/default_linear_damp")

    var timestep := 0.02
    var colors := [Color.RED, Color.BLUE]

    for i in range(70):
        velocity.y += gravity * timestep
        line_end = line_start + velocity * timestep
        velocity = velocity * clampf(1.0 - drag * timestep, 0.0, 1.0)

        _draw_line_global(line_start, line_end, colors[i % 2])
        line_start = line_end


func get_forward_direction() -> Vector2:
    return global_position.direction_to(get_global_mouse_position())

func _draw_line_global(from: Vector2, to: Vector2, color: Color, width: int = -1) -> void:
    draw_line(from - global_position, to - global_position, color, width)
