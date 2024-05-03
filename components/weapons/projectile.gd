class_name Projectile extends Area2D

var direction : Vector2
var speed : float

func _physics_process(delta: float) -> void:
	position += speed * direction * delta
