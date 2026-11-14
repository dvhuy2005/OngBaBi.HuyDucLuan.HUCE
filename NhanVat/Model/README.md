# Model nhân vật (Luân)

Kiểu low-poly giống kênh Low Poly Shorts: ảnh mặt bọc quanh đầu, tóc là khối riêng, quần áo là
"ảnh" quần áo thật (cổ áo, nút, túi, đường may, nếp nhăn), dép có quai.
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
- Mỗi model đã đúng chiều cao thật, để scale = 1: Tý 1,20 m · Hưng 1,25 m · Đức, Hường 1,38 m ·
  bà San 1,48 m · chú Kem 1,65 m. Bé (bản cũ) 1,15 m. Ông Ba Bị dựng cỡ 1,8 m, nên để scale khoảng 1,2.
- Trẻ con có chân ngắn, đầu to hơn người lớn (đúng dáng trẻ con).
- Gốc toạ độ nằm dưới chân, mặt quay về +Z.

## Khung xương
- Đức, bà San, lũ trẻ: `hips`, `chest`, `head`, `arm_l/r`, `forearm_l/r`, `leg_l/r`, `shin_l/r`.
  Mọi xương có rest thẳng đứng (rotation = identity), nên xoay bằng code
  (`Skeleton3D.set_bone_pose_rotation`) rất dễ.
- Ông Ba Bị: `hips`, `spine`, `chest`, `neck`, `head`, `upperarm/forearm/hand.L/R`,
  `thigh/shin/foot.L/R`. Có 12 mắt phát sáng (`Eye_01` … `Eye_23`); số lẻ dùng để chớp mắt.

## Mặt
Mặt các nhân vật được tạo bằng AI (người không có thật).
