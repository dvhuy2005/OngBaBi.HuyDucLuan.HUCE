# Model nhân vật (Luân)

Kiểu low-poly: ảnh mặt bọc quanh đầu low-poly, thân mượt, quần áo dùng texture vải thật.
Mỗi file `.glb` đã gói sẵn texture, chỉ cần kéo vào scene hoặc instance trong Godot.

| File | Nhân vật | Animation |
|---|---|---|
| `Duc.glb` | Đức (nhân vật chính) | chưa có |
| `BaSan.glb` | bà San | chưa có |
| `Hung.glb`, `Ty.glb`, `Huong.glb`, `Be.glb` | lũ trẻ trong xóm | chưa có |
| `ChuKem.glb` | chú Kem (đổi kem đồng nát), áo sơ mi xanh lính | chưa có |
| `ChuKemAoMua.glb` | chú Kem mặc áo mưa trùm mũ (cảnh đêm, hồi V) | chưa có |
| `OngBaBi.glb` | Ông Ba Bị | `idle-loop`, `walk-loop`, `run-loop`, `look-loop`, `grab` |

## Kích thước, hướng
- Model cao khoảng 1,8 m (cỡ người lớn). Trẻ con thì scale khoảng 0,65 đến 0,7; bà San khoảng 0,82; chú Kem để 1,0; Ông Ba Bị khoảng 1,2.
- Gốc toạ độ nằm dưới chân, mặt quay về +Z.

## Khung xương
- Đức, bà San, lũ trẻ: `hips`, `chest`, `head`, `arm_l/r`, `forearm_l/r`, `leg_l/r`, `shin_l/r`.
  Mọi xương có rest thẳng đứng (rotation = identity), nên xoay bằng code
  (`Skeleton3D.set_bone_pose_rotation`) rất dễ.
- Ông Ba Bị: `hips`, `spine`, `chest`, `neck`, `head`, `upperarm/forearm/hand.L/R`,
  `thigh/shin/foot.L/R`. Có 12 mắt phát sáng (`Eye_01` … `Eye_23`); số lẻ dùng để chớp mắt.

## Mặt
Mặt các nhân vật được tạo bằng AI (người không có thật).
