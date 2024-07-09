extends Node

func generate_circle_polygon(r: float, n: int, position: Vector2) -> PackedVector2Array:
    var x0 = position.x
    var y0 = position.y
    var theta_inc = 2 * PI / n
    
    var polygon: PackedVector2Array = []
    
    for i in range(n):
        var theta = i * theta_inc
        polygon.append(Vector2(x0 + r * cos(theta), y0 + r * sin(theta)))

    return polygon
