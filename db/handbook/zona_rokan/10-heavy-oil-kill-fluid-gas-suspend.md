---
title: "Heavy Oil: Kill Fluid, Gas & Suspend Well"
slug: zr-heavy-oil-kill-fluid-gas-suspend
position: 10
summary: Manajemen kill fluid dan brine, well signature H2S, mitigasi saat mengeluarkan fluida sumur, aktivitas malam hari, dan suspend sumur.
---

## Manajemen Kill Fluid

Kill fluid dipakai sejak initial killing sampai akhir pekerjaan, termasuk fill up sumur dan clean out sand. Tabel di bawah berlaku untuk killing **100 bbl atau kurang**. Killing di atas 100 bbl butuh tambahan tangki untuk menyiapkan fluida on hand 360 bbl. Bila rig memiliki kapasitas penyimpanan minimal 360 bbl, diskusikan penggunaannya dengan CE atau atasan.

| Case | Riwayat well control | Initial killing | Kondisi sumur | Clean out | Fluida on hand | Penanganan sisa fluida |
|---|---|---|---|---|---|---|
| 1 | Tidak ada | Air | Full | Air | 260 bbl | Dibuang ke stasiun pengumpul |
| 2 | Tidak ada | Air | Loss | Foam | 260 bbl | Dibuang ke stasiun pengumpul atau dipompakan ke sumur di akhir pekerjaan |
| 3 | Ada | Brine | Full | Brine | 180 bbl* | Dibuang ke stasiun pengumpul atau dipakai di sumur berikutnya |
| 4 | Ada | Brine | Loss | Tidak disarankan clean out | 180 bbl* | Dipompakan ke sumur di akhir pekerjaan |
| 5 | Ada | Air | Full | Air (cooling down dengan brine) | 180 bbl* | Dibuang ke stasiun pengumpul atau dipakai di sumur berikutnya |
| 6 | Ada | Air | Loss | Foam (cooling down dengan brine) | 180 bbl* | Dipompakan ke sumur di akhir pekerjaan |

\* Butuh safeguard tambahan sesuai risk assessment yang berlaku: selama fill up atau sirkulasi dari casing valve pertama, **casing valve kedua dibuka** agar aliran balik bisa dipantau. Bila aliran balik lebih kecil atau lebih besar dari laju pompa, itu indikasi loss atau kick. Satu kru khusus ditugaskan memantau, dan driller atau toolpusher segera shut-in bila ada anomali.

Sumur dengan riwayat well control kadang hanya butuh air untuk dimatikan (misalnya karena tekanan formasi atau injeksi uap di sekitarnya menurun). Bila sumur seperti ini perlu COS, **brine tetap dipakai** untuk clean out atau cooling down setelah COS, karena mungkin ada tekanan terkurung di bawah pasir yang bisa memicu kick (case 3, 5, dan 6). Pada case 5, siapkan tangki air tambahan karena menangani dua fluida sekaligus.

Rumus pengenceran brine dan pengaruh temperatur ada di artikel General Knowledge **Well Killing & Kill Fluid**.

## Completion Fluid Management

| Aspek | Panduan |
|---|---|
| Initial killing | Gunakan air bersih atau air formasi. Bila tidak cukup, gunakan air KCl. Bila killing tidak berhasil, konsultasikan ke CE untuk suspend atau lanjut dengan fluida kill. |
| Densitas kill fluid | SF (0,5 ppg) + 8,33 + [tekanan shut-in / (0,052 × TVD top perforation)]. Bullhead lewat tubing pakai SITP, lewat annulus pakai SICP. |
| Hole monitoring | Isi sumur berkala saat mencabut tubing, catat di trip sheet. |
| Loss rate | Isi penuh, tunggu 10 menit, isi kembali, catat volumenya. |
| Fluid loss | Tentukan laju dan frekuensi pengisian yang aman, lanjutkan sambil memantau, dan catat. Polymer atau LCM butuh persetujuan engineering. |
| Ketersediaan air | Pastikan vacuum truck tersedia dan catat waktu pengambilan per muatan. Bila sumur butuh lebih dari 1 bpm dan pengambilan air lebih dari 1 jam, minta tambahan vacuum truck. |

## Well Signature (H₂S)

Pada sumur dengan H₂S di atas ambang batas yang diizinkan (misalnya 1 ppm), well signature menjadi acuan jendela waktu kerja aman. Langkahnya ada di artikel General Knowledge **Drilling & Well Intervention Safety**.

## Mitigasi Saat Mengeluarkan Fluida Sumur

Selalu asumsikan gas ikut keluar. Contoh operasinya:

- Heavy oil: clean out sand, foaming out sand, unload acid dengan foaming, killing dengan metode sirkulasi.
- Light oil: clean out sand, reverse circulation, killing dengan metode sirkulasi.

Mitigasinya:

1. Setiap inlet dan outlet punya valve yang bisa menutup aliran. Valve dan flowline dites berkala dan buktinya siap ditunjukkan. Sebelum mengeluarkan fluida, pastikan line-up dari wellhead / kill line ke choke manifold dan ke tangki.
2. Bila terjadi akumulasi gas:
   - **Waspada** (LEL di atas 0–10%, H₂S di atas 1 ppm): kecilkan laju pompa atau choke aliran keluar, pantau.
   - **STOP** (LEL 10% atau lebih, H₂S di atas 1 ppm, oksigen di bawah 19,5% atau di atas 23,5%): hentikan pekerjaan, shut-in dengan metode 3S (space out, shut off pump, shut in), dan evakuasi.
3. Fixed gas monitoring wajib di titik keluar fluida, ditambah pengukuran gas tester dengan detektor portabel dari area aman.
4. Arahkan blower ke aliran keluar fluida, menjauhi rig.
5. Pastikan ERP ada dan dipahami semua kru.
6. Pertimbangkan untuk **tidak** melakukan COS di malam hari bila ada kondisi abnormal.

## Aktivitas Kritis di Malam Hari

Boleh dilakukan hanya bila semua terpenuhi:

1. Penerangan area kerja memadai.
2. Tiga pilar pimpinan (WSR, toolpusher, pimpinan kru) hadir di lokasi.
3. Kru tidak melewati batas jam kerja / fatigue.
4. Atasan dapat dihubungi.
5. Tidak ada indikasi abnormal: LEL di atas 0%, H₂S di atas 0 ppm, loss lebih dari 10 bbl/jam, atau kenaikan tekanan pompa lebih dari 100 psi dari baseline.

Bila satu tidak terpenuhi, amankan sumur, lanjut di siang hari, dan catat sebagai *waiting on daylight*.

## Suspend Sumur

Alasan umum dan aturan kondisi aman ada di artikel General Knowledge **Well Problem Handling**. Di Rig Hub, gunakan penulisan baku di ringkasan pekerjaan:

1. Job suspended due to tubing string stuck
2. Job suspended due to tubing hanger stuck
3. Job suspended due to fishing problem
4. Job suspended due to killing problem
5. Job suspended due to well integrity problem
6. Job suspended due to wellhead problem

**Isi wajib ringkasan pekerjaan untuk kasus stuck:**

1. Nilai overpull aktual. Bedakan overpull dengan tension.
2. Koneksi terlemah dan overpull yang disarankan, termasuk bila ada tail liner.
3. Bila tubing hanger bisa didudukkan kembali, cukup tulis *re-set tubing hanger*. Bila ada back-off, jelaskan.
4. Tulis alasan secara lengkap, jangan disingkat.
5. Pastikan ringkasan sinkron dengan time log. Data berat string dan block cukup di time log.

Company man / WSR wajib menyampaikan ke atasan dan engineer Rig Hub **sebelum** suspend, untuk memastikan semua prosedur sudah dilakukan.

### Kasus Tubing String Stuck

**Tubing hanger bisa didudukkan kembali:**

- Pada rig leapfrog, selesaikan sumur secara online oleh rig agar FOSV yang tertutup setelah N/D BOPE bisa dibuka.
- Coba ganti insert pump atau plunger bila komponen pengganti kompatibel dengan seating nipple / barrel di sumur. Pastikan ukuran dan koneksi rod untuk screw-in sudah benar.
- Bila tidak bisa diganti, laporkan jenis koneksi dan ukuran sucker rod yang tertinggal di tubing.

**Tubing hanger tidak bisa didudukkan kembali:**

- Lakukan back-off dan catat berat string yang terbebas. Bila mendekati estimasi berat sampai PSD, buka FOSV dan cabut sucker rod dulu sebelum mencabut tubing. Bila jauh lebih kecil, kemungkinan putus dekat permukaan.
- Lay down 1–2 joint dan pasang kembali tubing hanger.
- Laporkan jenis koneksi dan ukuran rod yang tertinggal. Penggantian pompa tidak perlu karena integritas tubing sudah hilang.

### Kasus Tubing String Parted

Hati-hati mencabut habis tubing saat rod masih di dalam, karena rod yang tadinya bersandar di tubing bisa jatuh ke dalam sumur.

- Coba screw-in tubing. Bila berhasil, cabut string dan rod yang tertinggal secara normal.
- Bila gagal, coba screw-in rangkaian sucker rod (dengan ukuran dan koneksi yang kompatibel) untuk mengeluarkan rod terlebih dahulu. Bila berhasil, tubing yang parted aman dicabut habis.
- Bila tetap gagal, suspend dengan data: berat tubing yang terangkat (dikurangi berat travelling block), serta jenis koneksi dan ukuran rod yang tertinggal.

### Jumlah Tubing untuk Suspend

1. F(up) = SICP atau MASP (yang lebih tinggi) × luas penampang.
   - Default: check valve dipasang di ujung bawah tubing, luas penampang = π × ID casing² / 4.
   - Sumur dangkal (kurang dari 500 ft): lepas check valve, luas penampang = π × (ID casing² − ID tubing²) / 4.
2. Panjang minimum tubing = F(up) / berat tubing per ft.
3. Bulatkan jumlah joint ke atas (rata-rata 1 joint = 30 ft).
4. Bila ada fish, pastikan ujung tubing tidak overlap dengan fish. Bila overlap, hitung ulang tanpa check valve.
5. Sucker rod yang tercabut tidak perlu dimasukkan kembali.
