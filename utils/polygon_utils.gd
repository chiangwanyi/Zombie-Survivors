extends Node

func generate_circle_polygon(r: float, n: int, position: Vector2) -> PackedVector2Array:
    var x0 = position.x
    var y0 = position.y
    var theta_inc = 2 * PI / n
    
    var polygon: PackedVector2Array
    
    for i in range(n):
        var theta = i * theta_inc
        polygon.append(Vector2(x0 + r * cos(theta), y0 + r * sin(theta)))
        #
    #var angle_delta: float = (PI * 2) / num_sides
    #var vector: Vector2 = Vector2(radius, 0)
    #var polygon: PackedVector2Array
#
    #for _i in num_sides:
        #polygon.append(vector + position)
        #vector = vector.rotated(angle_delta)

    return polygon
