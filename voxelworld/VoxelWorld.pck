GDPC                �                                                                         T   res://.godot/exported/133200997/export-45f71864b4615f1cc68d15bc7f66e483-Voxel.scn   I      K      ��+z����+�8ѷ    T   res://.godot/exported/133200997/export-8c3e294b056e7b3d3711b234598e6d2f-GameUI.scn  P      ~      q94'����)��RQ	    T   res://.godot/exported/133200997/export-90e1ff3baa03524a506ff0f7a9d78dcf-Player.scn  �;      �      ����N�����7    P   res://.godot/exported/133200997/export-bcb0d2eb5949c52b6a65bfe9de3e985b-Main.scn�.            � �I-�ꔆ,�ow_    P   res://.godot/exported/133200997/export-c3b50503a0477dc727cd659891fdb3c7-UI.scn  �B      8      $V��ߐ��'�E	��X    T   res://.godot/exported/133200997/export-eb419a944eb9eed40702fc462475be89-Ghost.scn          @      �7�%fRI9�A����    X   res://.godot/exported/133200997/export-fc149269868b4340b81450b2b62154cf-VoxelWorld.scn  `W      "      <��U`S�ݤ���6p�    ,   res://.godot/global_script_class_cache.cfg   �      F      ��*�"��'�L�qծ�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex@      �      �Yz=������������       res://.godot/uid_cache.bin  0�      �       ��i̖g,���X�       res://GameUI.gd         N      K1�	Hc�3��N^�       res://GameUI.tscn.remap  �      c        �p
�S�=4pF��/       res://Ghost.gd  �
      *      _f��/�)gR*��jY^9       res://Ghost.tscn.remap  ��      b       w=��Ц��.�a��p�       res://Main.gd   �)      �      ��}�6�����_,d       res://Main.tscn.remap    �      a       3 J�M�B�b��}�       res://Player.gd  2      �	      �fTMJ�u����"x^�       res://Player.tscn.remap p�      c       ^����[���:c��&       res://UI.tscn.remap �      _       }`�O�e8���bt�       res://Voxel.gd  �F            ���~n��E�,s8�_ן       res://Voxel.tscn.remap  @�      b       o ��c�0�]����       res://Voxel3D.gd�F      &       o7���;��ο��@=�N       res://VoxelWorld.tscn.remap ��      g       �Ey�-�,�رP��       res://icon.svg  p�      �      C��=U���^Qu��U3       res://icon.svg.import    )      �       N�X�p���_T
zE�       res://project.binary �      J      |Z�wӑ6o����u�#�       res://world.gd  py      �(      ��*x��m�0,��    #��_�W�^'class_name GameUI
extends Control

@onready var season_label: Label = $MarginContainer/VBoxContainer/Top/Season
@onready var counter_label: Label = $MarginContainer/VBoxContainer/Top/Counter
@onready var ghosted_label: Label = $MarginContainer/VBoxContainer/Ghosted
@onready var lifes_label: Label = $MarginContainer/VBoxContainer/Bottom/Lifes

func set_season(season: VoxelWorld.Season, counter: int):
	counter_label.text = "%s" % counter
	match season:
		VoxelWorld.Season.SUMMER:
			season_label.text = 'summer'
		VoxelWorld.Season.AUTUMN:
			season_label.text = 'autumn'
		VoxelWorld.Season.WINTER:
			season_label.text = 'winter'
		VoxelWorld.Season.SPRING:
			season_label.text = 'spring'
			
func set_ghosted(visible: bool):
	ghosted_label.set_visibility_layer_bit(1, visible)

func set_lifes(lifes: int):
	lifes_label.text = "%s" % lifes
8�RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://GameUI.gd ��������      local://PackedScene_mb3p8          PackedScene          	         names "         GameUI    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    mouse_filter    script    Control    MarginContainer %   theme_override_constants/margin_left $   theme_override_constants/margin_top &   theme_override_constants/margin_right '   theme_override_constants/margin_bottom    VBoxContainer    Top    size_flags_vertical    HBoxContainer    Season    text    Label    Counter    size_flags_horizontal    Ghosted    visibility_layer $   theme_override_font_sizes/font_size    horizontal_alignment    vertical_alignment    Bottom    Lifes    	   variants                        �?                                         season    
         1    <         GHOSTED             9       lifes       node_count    
         nodes     �   ��������	       ����                                                                
   
   ����
                                                                                ����                          ����                                ����                                ����            	      
                    ����                                                               ����                                ����            	                          ����                         conn_count              conns               node_paths              editable_instances              version             RSRC�class_name Ghost
extends CharacterBody3D

@export var player: CharacterBody3D 
@export var base_speed: float = 1.0

@export var collision_radius: float = 1.5
var max_height: float = 10.0

signal player_caught

func _physics_process(delta):
	if not player:
		return
		
	var direction_to_player = (player.global_transform.origin - global_transform.origin)
	if direction_to_player.length() > collision_radius:
		direction_to_player = direction_to_player.normalized()
		var current_speed = base_speed + (max_height - min(global_transform.origin.y, max_height))
		velocity = direction_to_player * current_speed
		move_and_slide()

	if global_transform.origin.distance_to(player.global_transform.origin) < collision_radius:
		on_player_collision()

func on_player_collision():
	player.caught()
	player_caught.emit()
��;�
tRSRC                    PackedScene            ��������                                            |      resource_local_to_scene    resource_name    lightmap_size_hint 	   material    custom_aabb    flip_faces    add_uv2    uv2_padding    radius    height    radial_segments    rings    script    render_priority 
   next_pass    transparency    blend_mode 
   cull_mode    depth_draw_mode    no_depth_test    shading_mode    diffuse_mode    specular_mode    disable_ambient_light    vertex_color_use_as_albedo    vertex_color_is_srgb    albedo_color    albedo_texture    albedo_texture_force_srgb    albedo_texture_msdf 	   metallic    metallic_specular    metallic_texture    metallic_texture_channel 
   roughness    roughness_texture    roughness_texture_channel    emission_enabled 	   emission    emission_energy_multiplier    emission_operator    emission_on_uv2    emission_texture    normal_enabled    normal_scale    normal_texture    rim_enabled    rim 	   rim_tint    rim_texture    clearcoat_enabled 
   clearcoat    clearcoat_roughness    clearcoat_texture    anisotropy_enabled    anisotropy    anisotropy_flowmap    ao_enabled    ao_light_affect    ao_texture 
   ao_on_uv2    ao_texture_channel    heightmap_enabled    heightmap_scale    heightmap_deep_parallax    heightmap_flip_tangent    heightmap_flip_binormal    heightmap_texture    heightmap_flip_texture    subsurf_scatter_enabled    subsurf_scatter_strength    subsurf_scatter_skin_mode    subsurf_scatter_texture &   subsurf_scatter_transmittance_enabled $   subsurf_scatter_transmittance_color &   subsurf_scatter_transmittance_texture $   subsurf_scatter_transmittance_depth $   subsurf_scatter_transmittance_boost    backlight_enabled 
   backlight    backlight_texture    refraction_enabled    refraction_scale    refraction_texture    refraction_texture_channel    detail_enabled    detail_mask    detail_blend_mode    detail_uv_layer    detail_albedo    detail_normal 
   uv1_scale    uv1_offset    uv1_triplanar    uv1_triplanar_sharpness    uv1_world_triplanar 
   uv2_scale    uv2_offset    uv2_triplanar    uv2_triplanar_sharpness    uv2_world_triplanar    texture_filter    texture_repeat    disable_receive_shadows    shadow_to_opacity    billboard_mode    billboard_keep_scale    grow    grow_amount    fixed_size    use_point_size    point_size    use_particle_trails    proximity_fade_enabled    proximity_fade_distance    msdf_pixel_range    msdf_outline_size    distance_fade_mode    distance_fade_min_distance    distance_fade_max_distance    custom_solver_bias    margin    size 	   _bundled       Script    res://Ghost.gd ��������      local://CapsuleMesh_hwmjl X      !   local://StandardMaterial3D_lphtw t         local://BoxShape3D_u86ea �         local://PackedScene_r5akg �         CapsuleMesh             StandardMaterial3D             BoxShape3D    z         ?ff�?   ?         PackedScene    {      	         names "   
      Ghost    collision_layer    collision_mask    script    CharacterBody3D    MeshInstance3D    mesh    surface_material_override/0    CollisionShape3D    shape    	   variants                                                          node_count             nodes     !   ��������       ����                                         ����                                 ����   	                conn_count              conns               node_paths              editable_instances              version             RSRCGST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح����mow�*��f�&��Cp�ȑD_��ٮ}�)� C+���UE��tlp�V/<p��ҕ�ig���E�W�����Sթ�� ӗ�A~@2�E�G"���~ ��5tQ#�+�@.ݡ�i۳�3�5�l��^c��=�x�Н&rA��a�lN��TgK㼧�)݉J�N���I�9��R���$`��[���=i�QgK�4c��%�*�D#I-�<�)&a��J�� ���d+�-Ֆ
��Ζ���Ut��(Q�h:�K��xZ�-��b��ٞ%+�]�p�yFV�F'����kd�^���:[Z��/��ʡy�����EJo�񷰼s�ɿ�A���N�O��Y��D��8�c)���TZ6�7m�A��\oE�hZ�{YJ�)u\a{W��>�?�]���+T�<o�{dU�`��5�Hf1�ۗ�j�b�2�,%85�G.�A�J�"���i��e)!	�Z؊U�u�X��j�c�_�r�`֩A�O��X5��F+YNL��A��ƩƗp��ױب���>J�[a|	�J��;�ʴb���F�^�PT�s�)+Xe)qL^wS�`�)%��9�x��bZ��y
Y4�F����$G�$�Rz����[���lu�ie)qN��K�<)�:�,�=�ۼ�R����x��5�'+X�OV�<���F[�g=w[-�A�����v����$+��Ҳ�i����*���	�e͙�Y���:5FM{6�����d)锵Z�*ʹ�v�U+�9�\���������P�e-��Eb)j�y��RwJ�6��Mrd\�pyYJ���t�mMO�'a8�R4��̍ﾒX��R�Vsb|q�id)	�ݛ��GR��$p�����Y��$r�J��^hi�̃�ūu'2+��s�rp�&��U��Pf��+�7�:w��|��EUe�`����$G�C�q�ō&1ŎG�s� Dq�Q�{�p��x���|��S%��<
\�n���9�X�_�y���6]���մ�Ŝt�q�<�RW����A �y��ػ����������p�7�l���?�:������*.ո;i��5�	 Ύ�ș`D*�JZA����V^���%�~������1�#�a'a*�;Qa�y�b��[��'[�"a���H�$��4� ���	j�ô7�xS�@�W�@ ��DF"���X����4g��'4��F�@ ����ܿ� ���e�~�U�T#�x��)vr#�Q��?���2��]i�{8>9^[�� �4�2{�F'&����|���|�.�?��Ȩ"�� 3Tp��93/Dp>ϙ�@�B�\���E��#��YA 7 `�2"���%�c�YM: ��S���"�+ P�9=+D�%�i �3� �G�vs�D ?&"� !�3nEФ��?Q��@D �Z4�]�~D �������6�	q�\.[[7����!��P�=��J��H�*]_��q�s��s��V�=w�� ��9wr��(Z����)'�IH����t�'0��y�luG�9@��UDV�W ��0ݙe)i e��.�� ����<����	�}m֛�������L ,6�  �x����~Tg����&c�U��` ���iڛu����<���?" �-��s[�!}����W�_�J���f����+^*����n�;�SSyp��c��6��e�G���;3Z�A�3�t��i�9b�Pg�����^����t����x��)O��Q�My95�G���;w9�n��$�z[������<w�#�)+��"������" U~}����O��[��|��]q;�lzt�;��Ȱ:��7�������E��*��oh�z���N<_�>���>>��|O�׷_L��/������զ9̳���{���z~����Ŀ?� �.݌��?�N����|��ZgO�o�����9��!�
Ƽ�}S߫˓���:����q�;i��i�]�t� G��Q0�_î!�w��?-��0_�|��nk�S�0l�>=]�e9�G��v��J[=Y9b�3�mE�X�X�-A��fV�2K�jS0"��2!��7��؀�3���3�\�+2�Z`��T	�hI-��N�2���A��M�@�jl����	���5�a�Y�6-o���������x}�}t��Zgs>1)���mQ?����vbZR����m���C��C�{�3o��=}b"/�|���o��?_^�_�+��,���5�U��� 4��]>	@Cl5���w��_$�c��V��sr*5 5��I��9��
�hJV�!�jk�A�=ٞ7���9<T�gť�o�٣����������l��Y�:���}�G�R}Ο����������r!Nϊ�C�;m7�dg����Ez���S%��8��)2Kͪ�6̰�5�/Ӥ�ag�1���,9Pu�]o�Q��{��;�J?<�Yo^_��~��.�>�����]����>߿Y�_�,�U_��o�~��[?n�=��Wg����>���������}y��N�m	n���Kro�䨯rJ���.u�e���-K��䐖��Y�['��N��p������r�Εܪ�x]���j1=^�wʩ4�,���!�&;ج��j�e��EcL���b�_��E�ϕ�u�$�Y��Lj��*���٢Z�y�F��m�p�
�Rw�����,Y�/q��h�M!���,V� �g��Y�J��
.��e�h#�m�d���Y�h�������k�c�q��ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[  ̔ց�ab,[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://ctrom37elyw33"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
 	M�T~Ğ�,��ِ2extends Node3D

@export var world_scene: PackedScene

enum WorldState { IDLE, GENERATING_DISPLAY, GENERATING, PLAYING, DEAD }

var world_state: WorldState = WorldState.IDLE
var world_instance: VoxelWorld
var games: int = 0

func _ready():
	enter_idle_state()

func _input(event):
	if world_state == WorldState.IDLE or world_state == WorldState.DEAD:
		if event.is_action_pressed("hit"):
			enter_generating_display_state()

func enter_idle_state():
	world_state = WorldState.IDLE
	$UI/CenterContainer/Label.text = "left click to start"
	
func enter_generating_display_state():
	world_state = WorldState.GENERATING_DISPLAY
	$UI/CenterContainer/Label.text = "generating world\nplease wait"
	await get_tree().create_timer(1.0).timeout
	enter_generating_state()

func enter_generating_state():
	world_state = WorldState.GENERATING
	world_instance = world_scene.instantiate()
	add_child(world_instance)
	world_instance.player_dead.connect(player_dead)
	enter_playing_state()
	
func enter_playing_state():
	world_state = WorldState.PLAYING
	$UI.visible = false

func player_dead():
	world_instance.queue_free()
	Engine.time_scale = 1
	world_state = WorldState.DEAD
	$UI.visible = true
	$UI/CenterContainer/Label.text = "GHOSTED TOO MUCH\nleft click to start"
R��̐�Ӱ��RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://Main.gd ��������   PackedScene    res://VoxelWorld.tscn �w���4   PackedScene    res://UI.tscn W���O�I#      local://PackedScene_6rq7l a         PackedScene          	         names "         Main    script    world_scene    Node3D    UI    	   variants                                         node_count             nodes        ��������       ����                            ���                    conn_count              conns               node_paths              editable_instances              version             RSRC =!�Ԛ~�gextends CharacterBody3D
class_name Player

@export var speed = 14
@export var rotation_speed = 3
@export var fall_acceleration = 75
@export var jump_impulse = 20
@export var sensitivity = 0.01
@export var vertical_sensitivity = 0.01
@export var max_look_up = 90
@export var max_look_down = -90

var lifes: int = 3

signal voxel_hit(voxel: Voxel, power: int)
signal voxel_place(voxel: Voxel)

var target_velocity = Vector3.ZERO
var pitch = 0
var hit_power = 40

var target_voxel: Voxel = null
var place_mode: bool = false

@onready var camera = $Pivot/Camera3D
@onready var raycast = $Pivot/Camera3D/RayCast3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * sensitivity)
		
		pitch -= event.relative.y * vertical_sensitivity
		pitch = clamp(pitch, deg_to_rad(max_look_down), deg_to_rad(max_look_up))
		camera.rotation.x = pitch

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
	if Input.is_action_just_pressed("build_mode"):
		place_mode = not place_mode
	update_target_voxel()
	handle_interaction()
	
	var direction = Vector3.ZERO

	if Input.is_action_pressed("move_right"):
		direction += transform.basis.x
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z
	if Input.is_action_pressed("move_back"):
		direction += transform.basis.z

	if direction != Vector3.ZERO:
		direction = direction.normalized()

	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	if not is_on_floor():
		target_velocity.y = velocity.y - (fall_acceleration * delta)
	else:
		target_velocity.y = 0
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		target_velocity.y = jump_impulse

	velocity = target_velocity
	move_and_slide()

func update_target_voxel():
	if raycast.is_colliding():
		var collided_object = raycast.get_collider()
		if collided_object and collided_object.voxel:
			target_voxel = collided_object.voxel
			return
	target_voxel = null

func handle_interaction():
	if target_voxel:
		if Input.is_action_just_pressed("place"):
			voxel_place.emit(target_voxel)
		if Input.is_action_just_pressed("hit"):
			voxel_hit.emit(target_voxel, hit_power)

func caught():
	lifes -= 1
	
func is_dead():
	return lifes <= 0
��p�FJRSRC                    PackedScene            ��������                                                  ..    resource_local_to_scene    resource_name    lightmap_size_hint 	   material    custom_aabb    flip_faces    add_uv2    uv2_padding    radius    height    radial_segments    rings    script    custom_solver_bias    margin    size 	   _bundled       Script    res://Player.gd ��������      local://CapsuleMesh_1i2wg          local://BoxShape3D_aoqqr 3         local://PackedScene_4ee2v N         CapsuleMesh             BoxShape3D             PackedScene          	         names "         Player 
   transform    collision_layer    collision_mask    script    CharacterBody3D    Pivot    Node3D 	   Camera3D    current 
   RayCast3D    target_position    debug_shape_custom_color    debug_shape_thickness 
   Character    mesh 	   skeleton    MeshInstance3D    CollisionShape3D    shape    	   variants            �?              �?              �?    �J�?                               �?              �?              �?       ?                       ��         ���>���>��V?  �?                                   �?              �?              �?       �                   node_count             nodes     F   ��������       ����                                              ����                     ����         	                 
   
   ����                        	                    ����      
                           ����                         conn_count              conns               node_paths              editable_instances              version             RSRC�8Z��@���0n���zRSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script           local://PackedScene_0ugtt �          PackedScene          	         names "         UI    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    Control 
   ColorRect    color    CenterContainer    offset_right    offset_bottom    Label    horizontal_alignment    	   variants    	                    �?                             �?            �D     "D      node_count             nodes     @   ��������       ����                                                          ����                                       	                  
   
   ����                                      ����                         conn_count              conns               node_paths              editable_instances              version             RSRC>� I��extends StaticBody3D

var voxel:Voxel
�vf%{f���class_name Voxel

enum VoxelType { GRASS, DIRT, SAND, WATER }

var position: Vector3
var type: VoxelType
var instance: StaticBody3D
var key: String
var hit_points: int = 100

func _init(_position: Vector3, _type: VoxelType):
	position = _position
	type = _type
	key = key_from_xyz(position.x, position.y, position.z)
	
func is_hidden():
	return not instance
	
func is_broken():
	return hit_points <= 0

func hit(power: int):
	hit_points -= power

static func key_from_xyz(x, y, z) -> String:
	return "{0}_{1}_{2}".format([x, y, z])
rI׶$J�/tp�RSRC                    PackedScene            ��������                                            |      ..    resource_local_to_scene    resource_name    lightmap_size_hint 	   material    custom_aabb    flip_faces    add_uv2    uv2_padding    size    subdivide_width    subdivide_height    subdivide_depth    script    render_priority 
   next_pass    transparency    blend_mode 
   cull_mode    depth_draw_mode    no_depth_test    shading_mode    diffuse_mode    specular_mode    disable_ambient_light    vertex_color_use_as_albedo    vertex_color_is_srgb    albedo_color    albedo_texture    albedo_texture_force_srgb    albedo_texture_msdf 	   metallic    metallic_specular    metallic_texture    metallic_texture_channel 
   roughness    roughness_texture    roughness_texture_channel    emission_enabled 	   emission    emission_energy_multiplier    emission_operator    emission_on_uv2    emission_texture    normal_enabled    normal_scale    normal_texture    rim_enabled    rim 	   rim_tint    rim_texture    clearcoat_enabled 
   clearcoat    clearcoat_roughness    clearcoat_texture    anisotropy_enabled    anisotropy    anisotropy_flowmap    ao_enabled    ao_light_affect    ao_texture 
   ao_on_uv2    ao_texture_channel    heightmap_enabled    heightmap_scale    heightmap_deep_parallax    heightmap_flip_tangent    heightmap_flip_binormal    heightmap_texture    heightmap_flip_texture    subsurf_scatter_enabled    subsurf_scatter_strength    subsurf_scatter_skin_mode    subsurf_scatter_texture &   subsurf_scatter_transmittance_enabled $   subsurf_scatter_transmittance_color &   subsurf_scatter_transmittance_texture $   subsurf_scatter_transmittance_depth $   subsurf_scatter_transmittance_boost    backlight_enabled 
   backlight    backlight_texture    refraction_enabled    refraction_scale    refraction_texture    refraction_texture_channel    detail_enabled    detail_mask    detail_blend_mode    detail_uv_layer    detail_albedo    detail_normal 
   uv1_scale    uv1_offset    uv1_triplanar    uv1_triplanar_sharpness    uv1_world_triplanar 
   uv2_scale    uv2_offset    uv2_triplanar    uv2_triplanar_sharpness    uv2_world_triplanar    texture_filter    texture_repeat    disable_receive_shadows    shadow_to_opacity    billboard_mode    billboard_keep_scale    grow    grow_amount    fixed_size    use_point_size    point_size    use_particle_trails    proximity_fade_enabled    proximity_fade_distance    msdf_pixel_range    msdf_outline_size    distance_fade_mode    distance_fade_min_distance    distance_fade_max_distance    custom_solver_bias    margin 	   _bundled       Script    res://Voxel3D.gd ��������      local://BoxMesh_0yqnh f      !   local://StandardMaterial3D_vanhd ~         local://BoxShape3D_47hgj �         local://PackedScene_fws8i �         BoxMesh             StandardMaterial3D          ���=���>  �?  �?         BoxShape3D             PackedScene    {      	         names "   	      StaticBody3D    collision_layer    script    MeshInstance3D    mesh 	   skeleton    surface_material_override/0    CollisionShape3D    shape    	   variants                                                                       node_count             nodes     !   ��������        ����                                  ����                                       ����                   conn_count              conns               node_paths              editable_instances              version             RSRC�DR�RSRC                    PackedScene            ��������                                            #     resource_local_to_scene    resource_name    sky_top_color    sky_horizon_color 
   sky_curve    sky_energy_multiplier 
   sky_cover    sky_cover_modulate    ground_bottom_color    ground_horizon_color    ground_curve    ground_energy_multiplier    sun_angle_max 
   sun_curve    use_debanding    script    sky_material    process_mode    radiance_size    background_mode    background_color    background_energy_multiplier    background_intensity    background_canvas_max_layer    background_camera_feed_id    sky    sky_custom_fov    sky_rotation    ambient_light_source    ambient_light_color    ambient_light_sky_contribution    ambient_light_energy    reflected_light_source    tonemap_mode    tonemap_exposure    tonemap_white    ssr_enabled    ssr_max_steps    ssr_fade_in    ssr_fade_out    ssr_depth_tolerance    ssao_enabled    ssao_radius    ssao_intensity    ssao_power    ssao_detail    ssao_horizon    ssao_sharpness    ssao_light_affect    ssao_ao_channel_affect    ssil_enabled    ssil_radius    ssil_intensity    ssil_sharpness    ssil_normal_rejection    sdfgi_enabled    sdfgi_use_occlusion    sdfgi_read_sky_light    sdfgi_bounce_feedback    sdfgi_cascades    sdfgi_min_cell_size    sdfgi_cascade0_distance    sdfgi_max_distance    sdfgi_y_scale    sdfgi_energy    sdfgi_normal_bias    sdfgi_probe_bias    glow_enabled    glow_levels/1    glow_levels/2    glow_levels/3    glow_levels/4    glow_levels/5    glow_levels/6    glow_levels/7    glow_normalized    glow_intensity    glow_strength 	   glow_mix    glow_bloom    glow_blend_mode    glow_hdr_threshold    glow_hdr_scale    glow_hdr_luminance_cap    glow_map_strength 	   glow_map    fog_enabled    fog_light_color    fog_light_energy    fog_sun_scatter    fog_density    fog_aerial_perspective    fog_sky_affect    fog_height    fog_height_density    volumetric_fog_enabled    volumetric_fog_density    volumetric_fog_albedo    volumetric_fog_emission    volumetric_fog_emission_energy    volumetric_fog_gi_inject    volumetric_fog_anisotropy    volumetric_fog_length    volumetric_fog_detail_spread    volumetric_fog_ambient_inject    volumetric_fog_sky_affect -   volumetric_fog_temporal_reprojection_enabled ,   volumetric_fog_temporal_reprojection_amount    adjustment_enabled    adjustment_brightness    adjustment_contrast    adjustment_saturation    adjustment_color_correction    lifetime_randomness    emission_shape    emission_sphere_radius    particle_flag_align_y    particle_flag_rotate_y    particle_flag_disable_z 
   direction    spread 	   flatness    gravity    initial_velocity_min    initial_velocity_max    angular_velocity_min    angular_velocity_max    angular_velocity_curve    linear_accel_min    linear_accel_max    linear_accel_curve    radial_accel_min    radial_accel_max    radial_accel_curve    tangential_accel_min    tangential_accel_max    tangential_accel_curve    damping_min    damping_max    damping_curve 
   angle_min 
   angle_max    angle_curve 
   scale_min 
   scale_max    scale_curve    color    color_ramp    color_initial_ramp    hue_variation_min    hue_variation_max    hue_variation_curve    turbulence_enabled    turbulence_noise_strength    turbulence_noise_scale    turbulence_noise_speed    turbulence_noise_speed_random    turbulence_influence_min    turbulence_influence_max $   turbulence_initial_displacement_min $   turbulence_initial_displacement_max    turbulence_influence_over_life    anim_speed_min    anim_speed_max    anim_speed_curve    anim_offset_min    anim_offset_max    anim_offset_curve    sub_emitter_mode    sub_emitter_keep_velocity    attractor_interaction_enabled    collision_mode    collision_use_scale    lightmap_size_hint 	   material    custom_aabb    flip_faces    add_uv2    uv2_padding    size    subdivide_width    subdivide_height    subdivide_depth    render_priority 
   next_pass    transparency    blend_mode 
   cull_mode    depth_draw_mode    no_depth_test    shading_mode    diffuse_mode    specular_mode    disable_ambient_light    vertex_color_use_as_albedo    vertex_color_is_srgb    albedo_color    albedo_texture    albedo_texture_force_srgb    albedo_texture_msdf 	   metallic    metallic_specular    metallic_texture    metallic_texture_channel 
   roughness    roughness_texture    roughness_texture_channel    emission_enabled 	   emission    emission_energy_multiplier    emission_operator    emission_on_uv2    emission_texture    normal_enabled    normal_scale    normal_texture    rim_enabled    rim 	   rim_tint    rim_texture    clearcoat_enabled 
   clearcoat    clearcoat_roughness    clearcoat_texture    anisotropy_enabled    anisotropy    anisotropy_flowmap    ao_enabled    ao_light_affect    ao_texture 
   ao_on_uv2    ao_texture_channel    heightmap_enabled    heightmap_scale    heightmap_deep_parallax    heightmap_flip_tangent    heightmap_flip_binormal    heightmap_texture    heightmap_flip_texture    subsurf_scatter_enabled    subsurf_scatter_strength    subsurf_scatter_skin_mode    subsurf_scatter_texture &   subsurf_scatter_transmittance_enabled $   subsurf_scatter_transmittance_color &   subsurf_scatter_transmittance_texture $   subsurf_scatter_transmittance_depth $   subsurf_scatter_transmittance_boost    backlight_enabled 
   backlight    backlight_texture    refraction_enabled    refraction_scale    refraction_texture    refraction_texture_channel    detail_enabled    detail_mask    detail_blend_mode    detail_uv_layer    detail_albedo    detail_normal 
   uv1_scale    uv1_offset    uv1_triplanar    uv1_triplanar_sharpness    uv1_world_triplanar 
   uv2_scale    uv2_offset    uv2_triplanar    uv2_triplanar_sharpness    uv2_world_triplanar    texture_filter    texture_repeat    disable_receive_shadows    shadow_to_opacity    billboard_mode    billboard_keep_scale    grow    grow_amount    fixed_size    use_point_size    point_size    use_particle_trails    proximity_fade_enabled    proximity_fade_distance    msdf_pixel_range    msdf_outline_size    distance_fade_mode    distance_fade_min_distance    distance_fade_max_distance 	   _bundled       Script    res://world.gd ��������   PackedScene    res://Voxel.tscn �ó���_   PackedScene    res://Ghost.tscn 6o�B���o   PackedScene    res://GameUI.tscn ��KҚ8   PackedScene    res://Player.tscn ��l�/�H   $   local://ProceduralSkyMaterial_1qiny J         local://Sky_gpxxi �         local://Environment_0h3p6 �      &   local://ParticleProcessMaterial_dl54y �         local://BoxMesh_tiq7o �         local://BoxMesh_tm4yo �      !   local://StandardMaterial3D_55pm0 �         local://PackedScene_tbt24          ProceduralSkyMaterial          ��?��G?��+?  �?         Sky                                   Environment                                  ParticleProcessMaterial 	   r         s        �?u         w            �?    {         @|        �@�      ��L=�      ���=         BoxMesh             BoxMesh             StandardMaterial3D    �         �         �      ��g?��P?��|?  �?         PackedScene    "     	         names "         Node3D    script    voxel_scene    ghost_scene    GameUI    DirectionalLight3D    WorldEnvironment    environment    Player    HitParticles 
   transform 	   emitting    amount 	   lifetime 	   one_shot    explosiveness    randomness    process_material    draw_pass_1    GPUParticles3D    PlaceVoxel    layers    mesh    surface_material_override/0    MeshInstance3D    	   variants                                                                   �?              �?              �?    r� ?                 )   333333�?         ��L>   �>                       �?              �?              �?    xCb?                                  node_count             nodes     S   ��������        ����                                  ���                            ����                      ����                     ���                         	   ����	   
                     	      
                                             ����   
                                  conn_count              conns               node_paths              editable_instances              version             RSRC�YI5z疸�class_name VoxelWorld
extends Node3D

enum Season { SUMMER, AUTUMN, WINTER, SPRING }

@export var voxel_scene: PackedScene
@export var ghost_scene: PackedScene
@export var world_size: Vector2i = Vector2i(100, 100)
@export var max_height: int = 20
@export var noise_frequency: float = 0.05

@export var water_level: float = 0.45
@export var sand_level: float = 0.5
@export var terrain_level: float = 0.55
@export var grass_level: float = 1.0

@onready var player: Player = $Player
@onready var game_ui: GameUI = $GameUI
@onready var hit_particles: GPUParticles3D = $HitParticles
@onready var place_voxel_instance: MeshInstance3D = $PlaceVoxel

signal player_dead

var noise := FastNoiseLite.new()
var random = RandomNumberGenerator.new()

var water_material = StandardMaterial3D.new()
var sand_material = StandardMaterial3D.new()
var terrain_material = StandardMaterial3D.new()
var grass_material = StandardMaterial3D.new()

var season_timer: Timer = Timer.new()
var ghosted_timer: Timer = Timer.new()

var world_map_dict: Dictionary = {}
var season_index: int = 0
var seasons: Array = [Season.SUMMER, Season.AUTUMN, Season.WINTER, Season.SPRING]
const SEASON_DURATION: float = 20.0
var ghosts: Array = []
const GHOSTING_SCALE: float = 0.05
const GHOSTING_DURATION: float = 1.0 * 0.05

func _ready():
	start()

func start():
	var time_start = Time.get_unix_time_from_system()
	setup_materials()
	setup_noise()
	generate_world()
	add_invisible_walls()
	create_world()
	setup_signals()
	setup_timers()
	update_season()
	update_lifes()
	var time_end = Time.get_unix_time_from_system()
	var time_elapsed = time_end - time_start
	print(time_elapsed)

func setup_timers():
	add_child(season_timer)
	season_timer.timeout.connect(next_season)
	season_timer.start(SEASON_DURATION)
	add_child(ghosted_timer)
	ghosted_timer.one_shot = true
	ghosted_timer.timeout.connect(end_ghosting)

func end_ghosting():
	game_ui.set_ghosted(false)
	Engine.time_scale = 1

func update_lifes():
	game_ui.set_lifes(player.lifes)

func update_season():
	setup_materials()
	var season = get_season()
	game_ui.set_season(season, season_index + 1)
	if season == Season.WINTER:
		for i in season_index:
			create_ghost()
	else:
		clear_ghosts()

func clear_ghosts():
	if ghosts.size() > 0:
		for ghost in ghosts:
			ghost.queue_free()
		ghosts.clear()

func next_season():
	season_index += 1
	update_season()

func setup_signals():
	player.voxel_hit.connect(on_voxel_hit)
	player.voxel_place.connect(on_voxel_place)

func on_voxel_hit(voxel: Voxel, power: int):
	voxel.hit(power)
	if voxel.is_broken():
		remove_voxel(voxel)
	else:
		play_hit_particles_at_voxel(voxel)
	
func on_voxel_place(voxel: Voxel):
	var placed = place_voxel(voxel)
	if placed:
		play_hit_particles_at_voxel(voxel)

func play_hit_particles_at_voxel(voxel: Voxel):
	if voxel.instance:
		hit_particles.position = voxel.instance.position
		hit_particles.position.y += 0.5
		hit_particles.restart()

func get_season():
	return seasons[fmod(season_index, seasons.size())]

func setup_materials():
	var season = get_season()
	match season:
		Season.WINTER:
			water_material.albedo_color = Color(0.5, 0.8, 1.0)
			sand_material.albedo_color = Color(1.0, 1.0, 0.9)
			terrain_material.albedo_color = Color(0.9, 0.85, 0.7)
			grass_material.albedo_color = Color(0.7, 1.0, 0.7)
		_:
			water_material.albedo_color = Color(0.0, 0.4, 0.8)
			sand_material.albedo_color = Color(1.0, 0.9, 0.6)
			terrain_material.albedo_color = Color(0.5, 0.35, 0.2)
			grass_material.albedo_color = Color(0.3, 0.8, 0.2)

func setup_noise():
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.frequency = noise_frequency

func get_material(voxel_type: Voxel.VoxelType):
	match voxel_type:
		Voxel.VoxelType.WATER:
			return water_material
		Voxel.VoxelType.SAND:
			return sand_material
		Voxel.VoxelType.DIRT:
			return terrain_material
		Voxel.VoxelType.GRASS:
			return grass_material
	return water_material
	
func get_voxel_type(height_value: float):
	if height_value <= water_level:
		return Voxel.VoxelType.WATER
	elif height_value <= sand_level:
		return Voxel.VoxelType.SAND
	elif height_value <= terrain_level:
		return Voxel.VoxelType.DIRT
	elif height_value <= grass_level:
		return Voxel.VoxelType.GRASS
	return Voxel.VoxelType.GRASS

func get_voxel_at(x: int, y: int, z: int) -> Voxel:
	var key = Voxel.key_from_xyz(x, y, z)
	if not world_map_dict.has(key):
		return null
	return world_map_dict[key]

func is_voxel_hidden(voxel: Voxel):
	for diff in direct_neighbours_dx:
		var x = voxel.position.x + diff.x
		var y = voxel.position.y + diff.y
		var z = voxel.position.z + diff.z
		var neighbour = get_voxel_at(x, y, z)
		if y > 0 and not neighbour:
			return false
	return true

func create_voxel(voxel: Voxel):
	var voxel_instance = voxel_scene.instantiate()
	voxel_instance.transform.origin = voxel.position
	var material = get_material(voxel.type)
	voxel_instance.get_node("MeshInstance3D").set_surface_override_material(0, material)
	voxel.instance = voxel_instance
	voxel_instance.voxel = voxel
	add_child(voxel_instance)

func create_world():
	var count = 0
	for key in world_map_dict:
		var voxel = world_map_dict[key]
		if not is_voxel_hidden(voxel):
			count += 1
			create_voxel(voxel)
	print("visible ", count)

func create_ghost():
	var ghost_instance = ghost_scene.instantiate()
	ghost_instance.player = player
	var ghost_position = Vector3.ZERO
	ghost_position.y = max_height
	if random.randf() > 0.5:
		ghost_position.z = random.randf_range(0.0, world_size.y)
	else:
		ghost_position.x = random.randf_range(0.0, world_size.x)
	ghost_instance.position = ghost_position
	ghost_instance.player_caught.connect(player_caught)
	add_child(ghost_instance)
	ghosts.append(ghost_instance)

func player_caught():
	update_lifes()
	clear_ghosts()
	if player.is_dead():
		player_dead.emit()
	else:
		Engine.time_scale = GHOSTING_SCALE
		ghosted_timer.start(GHOSTING_DURATION)
		game_ui.set_ghosted(true)

func hide_voxel(voxel: Voxel):
	if voxel.instance:
		voxel.instance.queue_free()
		voxel.instance = null

func destroy_voxel(voxel: Voxel):
	hide_voxel(voxel)
	world_map_dict[voxel.key] = null

func remove_voxel(voxel: Voxel):
	if voxel.position.y > 0:
		destroy_voxel(voxel)
		for diff in direct_neighbours_dx:
			var x = voxel.position.x + diff.x
			var y = voxel.position.y + diff.y
			var z = voxel.position.z + diff.z
			var neighbour = get_voxel_at(x, y, z)
			if neighbour and neighbour.is_hidden() and not is_voxel_hidden(neighbour):
				create_voxel(neighbour)

func move_place_voxel(voxel: Voxel):
	var x = voxel.position.x
	var y = voxel.position.y
	var z = voxel.position.z
	var dir = voxel.position.direction_to(player.position)
	if (abs(dir.x) > abs(dir.y) and abs(dir.x) > abs(dir.z)):
		x += 1 * sign(dir.x)
	if (abs(dir.y) > abs(dir.x) and abs(dir.y) > abs(dir.z)):
		y += 1 * sign(dir.y)
	if (abs(dir.z) > abs(dir.x) and abs(dir.z) > abs(dir.y)):
		z += 1 * sign(dir.z)
	var dest = get_voxel_at(x, y, z)
	if not dest:
		place_voxel_instance.visible = true
		place_voxel_instance.position = Vector3(x, y, z)
	else:
		place_voxel_instance.visible = true

func place_voxel(voxel: Voxel):
	var x = voxel.position.x
	var y = voxel.position.y
	var z = voxel.position.z
	var dir = voxel.position.direction_to(player.position)
	if (abs(dir.x) > abs(dir.y) and abs(dir.x) > abs(dir.z)):
		x += 1 * sign(dir.x)
	if (abs(dir.y) > abs(dir.x) and abs(dir.y) > abs(dir.z)):
		y += 1 * sign(dir.y)
	if (abs(dir.z) > abs(dir.x) and abs(dir.z) > abs(dir.y)):
		z += 1 * sign(dir.z)
	var dest = get_voxel_at(x, y, z)
	if not dest:
		var voxel_position = Vector3(x, y, z)
		var voxel_type = Voxel.VoxelType.GRASS
		var new_voxel = Voxel.new(voxel_position, voxel_type)
		world_map_dict[new_voxel.key] = new_voxel
		create_voxel(new_voxel)
		return true
	return false

var direct_neighbours_dx: Array = [
	Vector3i(0, 1, 0),
	Vector3i(0, -1, 0),
	Vector3i(1, 0, 0),
	Vector3i(-1, 0, 0),
	Vector3i(0, 0, 1),
	Vector3i(0, 0, -1),
]

func generate_world():
	world_map_dict = {}
	var highest: Vector3 = Vector3.ZERO
	for x in range(world_size.x):
		for z in range(world_size.y):
			var height_value = (noise.get_noise_2d(x, z) + 1.0) / 2.0
			var height = int(height_value * max_height)
			for y in range(height):
				var voxel_position = Vector3(x, y, z)
				var voxel_type = get_voxel_type(height_value)
				var voxel = Voxel.new(voxel_position, voxel_type)
				if voxel_position.y > highest.y:
					highest = voxel_position
				world_map_dict[voxel.key] = voxel
	player.position = highest
	player.position.y += 3
	
func _physics_process(delta):
	if player.place_mode and player.target_voxel:
		move_place_voxel(player.target_voxel)
	else:
		place_voxel_instance.visible = false

func add_invisible_walls():
	# Create an invisible wall at x = 0
	var wall_left = StaticBody3D.new()
	var collision_shape_left = CollisionShape3D.new()
	var box_shape_left = BoxShape3D.new()
	box_shape_left.extents = Vector3(0.5, 1000, world_size.y / 2)
	collision_shape_left.shape = box_shape_left
	wall_left.add_child(collision_shape_left)
	wall_left.transform.origin = Vector3(-0.5, 0, world_size.y / 2)
	add_child(wall_left)

	# Create an invisible wall at x = world_size.x
	var wall_right = StaticBody3D.new()
	var collision_shape_right = CollisionShape3D.new()
	var box_shape_right = BoxShape3D.new()
	box_shape_right.extents = Vector3(0.5, 1000, world_size.y / 2)
	collision_shape_right.shape = box_shape_right
	wall_right.add_child(collision_shape_right)
	wall_right.transform.origin = Vector3(world_size.x - 0.5, 0, world_size.y / 2)
	add_child(wall_right)

	# Create an invisible wall at z = 0
	var wall_front = StaticBody3D.new()
	var collision_shape_front = CollisionShape3D.new()
	var box_shape_front = BoxShape3D.new()
	box_shape_front.extents = Vector3(world_size.x / 2, 1000, 0.5)
	collision_shape_front.shape = box_shape_front
	wall_front.add_child(collision_shape_front)
	wall_front.transform.origin = Vector3(world_size.x / 2, 0, -0.5)
	add_child(wall_front)

	# Create an invisible wall at z = world_size.y
	var wall_back = StaticBody3D.new()
	var collision_shape_back = CollisionShape3D.new()
	var box_shape_back = BoxShape3D.new()
	box_shape_back.extents = Vector3(world_size.x / 2, 1000, 0.5)
	collision_shape_back.shape = box_shape_back
	wall_back.add_child(collision_shape_back)
	wall_back.transform.origin = Vector3(world_size.x / 2, 0, world_size.y - 0.5)
	add_child(wall_back)
W�[remap]

path="res://.godot/exported/133200997/export-8c3e294b056e7b3d3711b234598e6d2f-GameUI.scn"
��VÑ���V�,[remap]

path="res://.godot/exported/133200997/export-eb419a944eb9eed40702fc462475be89-Ghost.scn"
buh�� k�g���[remap]

path="res://.godot/exported/133200997/export-bcb0d2eb5949c52b6a65bfe9de3e985b-Main.scn"
��I�&S�6t�~��([remap]

path="res://.godot/exported/133200997/export-90e1ff3baa03524a506ff0f7a9d78dcf-Player.scn"
�4�hp�ԑ!��[remap]

path="res://.godot/exported/133200997/export-c3b50503a0477dc727cd659891fdb3c7-UI.scn"
�[remap]

path="res://.godot/exported/133200997/export-45f71864b4615f1cc68d15bc7f66e483-Voxel.scn"
������*�Vs`[remap]

path="res://.godot/exported/133200997/export-fc149269868b4340b81450b2b62154cf-VoxelWorld.scn"
y^j�b�O�list=Array[Dictionary]([{
"base": &"Control",
"class": &"GameUI",
"icon": "",
"language": &"GDScript",
"path": "res://GameUI.gd"
}, {
"base": &"CharacterBody3D",
"class": &"Ghost",
"icon": "",
"language": &"GDScript",
"path": "res://Ghost.gd"
}, {
"base": &"CharacterBody3D",
"class": &"Player",
"icon": "",
"language": &"GDScript",
"path": "res://Player.gd"
}, {
"base": &"RefCounted",
"class": &"Voxel",
"icon": "",
"language": &"GDScript",
"path": "res://Voxel.gd"
}, {
"base": &"Node3D",
"class": &"VoxelWorld",
"icon": "",
"language": &"GDScript",
"path": "res://world.gd"
}])
��
���Jw�<svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
�GsoSv�g�	   ��KҚ8   res://GameUI.tscn6o�B���o   res://Ghost.tscn[i�Y->U   res://icon.svg�M��\   res://Main.tscn��l�/�H   res://Player.tscnW���O�I#   res://UI.tscn�ó���_   res://Voxel.tscn�w���4   res://VoxelWorld.tscnяu�ݝ�,��ECFG      application/config/name      
   VoxelWorld     application/run/main_scene         res://Main.tscn    application/config/features(   "         4.1    GL Compatibility       application/config/icon         res://icon.svg     input/move_left0              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   A   	   key_label             unicode    a      echo          script         input/move_right0              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   D   	   key_label             unicode    d      echo          script         input/move_back0              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   S   	   key_label             unicode    s      echo          script         input/move_forward0              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   W   	   key_label             unicode    w      echo          script      
   input/jump�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode       	   key_label             unicode           echo          script      	   input/hit�              deadzone      ?      events              InputEventMouseButton         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          button_mask           position              global_position               factor       �?   button_index         canceled          pressed           double_click          script         input/place�              deadzone      ?      events              InputEventMouseButton         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          button_mask           position              global_position               factor       �?   button_index         canceled          pressed           double_click          script         input/build_mode�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   E   	   key_label             unicode    e      echo          script      #   rendering/renderer/rendering_method         gl_compatibility*   rendering/renderer/rendering_method.mobile         gl_compatibility(��t�[