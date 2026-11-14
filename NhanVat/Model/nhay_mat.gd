extends Node
## Cho nhân vật tự nháy mắt.
## Cách dùng: thêm một Node làm con của model nhân vật (Duc.glb, BaSan.glb, ...) rồi gắn script này.
## Script tự tìm mí mắt (MeshInstance3D "MiMat" có blend shape "Blink") trong model cha.
## Gọi blink() để nháy ngay (ví dụ lúc nhân vật giật mình), set_closed(true) để nhắm hẳn (ngủ).

@export var tu_dong := true          ## Tự nháy ngẫu nhiên
@export var cach_min := 2.0          ## Khoảng nghỉ ngắn nhất giữa hai lần nháy (giây)
@export var cach_max := 6.0          ## Khoảng nghỉ dài nhất
@export var thoi_gian := 0.14        ## Một lần nháy dài bao lâu (giây)
@export var nhay_doi := 0.2          ## Tỉ lệ nháy hai cái liền

var _lids: Array[MeshInstance3D] = []
var _idx: Array[int] = []
var _cho := 0.0
var _nham := false
var _tween: Tween


func _ready() -> void:
	var goc := get_parent()
	for mi in goc.find_children("*", "MeshInstance3D", true, false):
		var i := (mi as MeshInstance3D).find_blend_shape_by_name("Blink")
		if i != -1:
			_lids.append(mi)
			_idx.append(i)
	if _lids.is_empty():
		push_warning("nhay_mat.gd: không thấy blend shape 'Blink' trong %s" % goc.name)
	_cho = randf_range(cach_min, cach_max)


func _process(delta: float) -> void:
	if not tu_dong or _nham or _lids.is_empty():
		return
	_cho -= delta
	if _cho <= 0.0:
		blink()
		_cho = randf_range(cach_min, cach_max)


## Nháy một lần (hoặc hai lần liền, ngẫu nhiên).
func blink() -> void:
	if _lids.is_empty() or _nham:
		return
	if _tween:
		_tween.kill()
	_tween = create_tween()
	var lan := 2 if randf() < nhay_doi else 1
	for k in lan:
		_tween.tween_method(_dat, 0.0, 1.0, thoi_gian * 0.4)
		_tween.tween_method(_dat, 1.0, 0.0, thoi_gian * 0.6)
		if k < lan - 1:
			_tween.tween_interval(0.08)


## Nhắm hẳn (true) hoặc mở mắt (false).
func set_closed(nham: bool) -> void:
	_nham = nham
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_method(_dat, 1.0 - float(nham), float(nham), 0.25)


func _dat(v: float) -> void:
	for j in _lids.size():
		_lids[j].set_blend_shape_value(_idx[j], v)
