extends Node3D
class_name FaceTarget


@export var turn_speed = 100.0

func face_point(point: Vector3, dt: float):
  var l_point = to_local(point)
  l_point.y = 0.0
  var turn_dir = sign(l_point.x)
  var angle = Vector3.FORWARD.angle_to(l_point)
  var turn_amnt = min(deg_to_rad(turn_speed * dt), angle)
  
  self.rotate_object_local(Vector3.UP, -turn_amnt * turn_dir)
  
func is_facing_target(target_point: Vector3):
  var l_target_pos = to_local(target_point)
  return l_target_pos.z < 0 and abs(l_target_pos.x) < 1.0
