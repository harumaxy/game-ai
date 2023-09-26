extends Node3D

@export var vision_cone_arc = 60.0


var target: Node3D
var red = color_mat(Color(1,0,0))
var yellow = color_mat(Color(1,1,0))

@onready var mesh : Mesh = $FaceTargetY/MeshInstance3D.mesh
@onready var face_target_y : FaceTarget = $FaceTargetY
@onready var face_target_x : FaceTarget = $FaceTargetY/FaceTargetX



func _ready() -> void:
  var targets = get_tree().get_nodes_in_group("targets")
  if targets.size() == 0:
    return
  target = targets[0]
  print(mesh)

func _process(delta: float) -> void:
  face_target_y.face_point(target.global_position, delta)
  face_target_x.face_point(target.global_position, delta)
  
  if face_target_y.is_facing_target(target.global_position):
    mesh.surface_set_material(0, red)
  else:
    mesh.surface_set_material(0, yellow)


func in_vision_cone():
  pass



func color_mat(color: Color) -> StandardMaterial3D:
  var mat = StandardMaterial3D.new()
  mat.albedo_color = color
  return mat
