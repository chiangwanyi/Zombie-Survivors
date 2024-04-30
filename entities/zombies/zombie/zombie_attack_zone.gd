extends DamageOnTouch

func _ready() -> void:
	repeat_damage_over_time = true
	damage_taken_health = Health.new(1, true)
	add_child(damage_taken_health)
