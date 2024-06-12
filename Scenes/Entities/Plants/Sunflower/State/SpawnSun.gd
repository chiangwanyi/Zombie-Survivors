extends State

var sun_scene := load("res://Scenes/Entities/Projectile/Sun/sun.tscn") as PackedScene


func enter() -> void:
	var light := $"../../PointLight2D" as PointLight2D
	var tween := create_tween()
	tween.tween_property(light, "energy", 1, 1)
	tween.tween_callback(_spawn_sun)
	tween.tween_property(light, "energy", 0, 1)
	tween.tween_callback(func ():
		emit_signal("finished", "Idle"))
	super.enter()

func _spawn_sun() -> void:
	var sun := sun_scene.instantiate() as RigidBody2D
	sun.position = (owner as Plant).position
	GameManager.current_level_name.add_child(sun)

func update(_delta: float) -> void:
	pass
	
func exit() -> void:
	super.exit()

