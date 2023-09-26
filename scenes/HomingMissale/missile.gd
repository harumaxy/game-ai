extends CharacterBody3D
class_name Missile

var target: Node3D
var move_speed = 0
var exploded = false

@onready var face_y : FaceTarget
@onready var face_x : FaceTarget


func setup(_target, _move_speed, turn_speed):
  target = _target
  move_speed = _move_speed
  face_y = $FaceTargetY
  face_x = $FaceTargetY/FaceTargetX
  face_y.turn_speed = turn_speed
  face_x.turn_speed = turn_speed
  return self
  
func _physics_process(delta: float) -> void:
  if !is_instance_valid(target): return
  
  var move_dir = face(target, delta)
  var coll = move_and_collide(move_dir * move_speed * delta)
  if coll:
    explode()
    

func explode():
  if exploded: return
  exploded = true
  self.collision_layer = 0
  self.collision_mask = 0
  self.set_physics_process(false)
  $Graphics/TrailParticles.emitting = false
  $ExplosionParticle.restart()
  $Graphics/Rocket.hide()
  $DeleteTimer.start()
  

func face(target: Node3D, delta: float) -> Vector3:
  face_x.face_point(target.global_position, delta)
  face_y.face_point(target.global_position, delta)
  return -$FaceTargetY/FaceTargetX/DirRef.global_transform.basis.z
