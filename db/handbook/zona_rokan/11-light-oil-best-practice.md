---
title: Light Oil Best Practice
slug: zr-light-oil-best-practice
position: 11
summary: Best practice lapangan light oil, termasuk operasi satu barrier, komplikasi killing, asesmen lokasi, ESP, manajemen GOR, dan pump spacing SRP.
---

## Initial Killing dan Operasi Satu Barrier

Pada sumur non-SRP (misalnya ESP), langkah N/D tree dan N/U BOP adalah operasi satu barrier. Garis besar alurnya: verifikasi tekanan sebelum melepas salah satu barrier, dan pastikan fluida cukup sampai dua barrier bisa ditegakkan kembali.

**RIH ESP:**

- Pastikan kru memahami prosedur non-sealable, shut-in, dan hole monitoring.
- Siapkan safety joint dan cable cutter di lantai kerja.
- Line-up sirkulasi ke tangki agar aliran bisa dialihkan sebelum shut-in.

**N/D BOP:**

- Pasang tubing hanger lengkap dengan FOSV tertutup.
- Pressure test tubing hanger sesuai checklist. Untuk tubing hanger non-mandrel EFT, pastikan syarat pengecualian tes terpenuhi.
- Cek tekanan sebelum N/D BOP (tubing hanger non-mandrel) atau sebelum N/D FOSV (mandrel EFT).

**N/U production tree:** cek SICP dan SITP sebelum melepas FOSV, lalu tes production tree sesuai checklist.

## Komplikasi Initial Killing

Reservoir light oil sangat beragam, sehingga tidak semua sumur bisa dimatikan dengan bullhead.

**1. Reservoir ketat (laju injeksi di bawah 1 bpm):**

1. Pompa dengan laju maksimum mud pump selama 1 jam pertama, lalu shut-in dan observasi.
2. Bila SICP dan SITP belum nol, ganti ke metode reverse.
3. Bila belum berhasil, pertimbangkan fluida lebih berat seperti brine, selama sumur tidak loss (diskusikan dengan CE atau atasan).

**2. Tekanan hanya di sisi tubing (SICP = 0, SITP tidak nol):**

1. Curigai tekanan berasal dari reservoir atau tekanan terkurung.
2. Bleed bertahap (per 10%), shut-in saat target tercapai, lalu amati. Bila naik lagi ke SITP awal, bukan tekanan terkurung.
3. Lakukan metode reverse (pertimbangkan brine).
4. Bila tidak ada komunikasi antara annulus dan tubing, gunakan metode lube and bleed di sisi tubing setelah berkonsultasi dengan CE, atasan, dan ahli well control.

## Asesmen dan Persiapan Lokasi

Dua dokumen yang dilengkapi sebelum eksekusi:

1. **Formulir standar asesmen lokasi**, sebagai checklist agar semua informasi lengkap dan material serta lokasi bisa disiapkan lebih awal. Untuk pekerjaan dengan peralatan tambahan di permukaan (misalnya retrofit wellhead), cek tinggi wellhead, tinggi master valve, serta ukuran dan rating wellhead.
2. **Layout peralatan rig**, sebagai gambaran visual kondisi aktual agar tidak ada pekerjaan berulang atau suspend karena peralatan tidak bisa di-set. Layout juga menunjukkan fasilitas umum di sekitar sumur yang mungkin perlu SIMOPS atau sosialisasi ke warga.

Sesuai pedoman nasional pemboran dan kerja ulang, radius minimum **100 meter** dari kepala sumur harus bebas dari kegiatan umum yang bisa menimbulkan sumber nyala, gas beracun, atau bahaya lain.

## Electric Submersible Pump

Komponen dan prinsip ESP ada di artikel General Knowledge **Artificial Lift**. Hal khusus di lapangan light oil:

- Perakitan pompa dan sambungan kabel dilakukan oleh field engineer penyedia jasa, dengan pengecekan minimal pada kondisi fisik motor dan pompa, putaran mekanis, oli, flange, shaft extension, megger, intake, dan discharge.
- Intake standar dipakai pada sumur dengan GLR rendah (gas masuk kurang dari sekitar 10–15% volume fluida). Untuk gas lebih tinggi, gunakan gas separator atau gas handler.

### Komplesi dengan Capillary Tube

Tubing hanger dimodifikasi dengan lubang dan ulir untuk fitting. Gunakan tipe tubing hanger penetrator (bukan desain lama) karena ada isu integritas material. Karena pernah terjadi kebocoran lewat lubang capillary, **selalu tes fitting capillary** (ditutup plug dari kru ESP) bersamaan dengan seal tubing hanger.

### Retrofit Tubing Hanger Mandrel EFT

Sebagian sumur masih memakai tubing hanger desain lama yang tidak bisa diverifikasi sebagai barrier. Bila tidak memenuhi kriteria pengecualian, wellhead diubah ke tipe mandrel EFT. Selama masih memakai tipe lama, wajib: kabel ESP di penetrator adalah AWG #1, dan seal tubing hanger diganti.

Rig Hub hanya mendukung pemasangan tubing hanger mandrel EFT (retrofit). Pekerjaan pemotongan casing dan penggantian wellhead di luar lingkup Rig Hub. Asesmen kritis:

1. **Tinggi wellhead**: laporkan bila BOP stack dan drip pan berpotensi tidak bisa dipasang setelah retrofit. Catat tinggi BOP stack tiap rig.
2. **Ukuran dan rating flange existing**, untuk persiapan material.
3. **Tinggi master valve** dengan stem horizontal dibatasi sampai sekitar **5,8 ft**.

### Tail Liner Screen pada ESP

Masalah pasir sering ditemui di sumur rod pump maupun ESP. Memperbaiki sand control secara total tidak selalu ekonomis, sehingga dipakai stand-alone screen.

| Metode | Kelebihan | Kekurangan |
|---|---|---|
| Screen dipasang terpisah dengan packer (program kerja ulang) | Lebih aman dari pompa stuck | Biaya dan material lebih besar |
| Screen disambung langsung ke pompa (program routine service) | Satu trip, bisa diganti bersama pompa | Potensi ESP stuck bila screen terjepit pasir |

Pemasangan di ESP memakai casing shroud yang menyelubungi intake, atau tail liner dengan cup packer assembly. Konfigurasi tail liner: cup packer, safety joint, perforated tubing, dan screen liner yang dipilih oleh engineer.

![Perbandingan instalasi liner konvensional dan tail liner pada ESP](/handbook-images/tail-liner-esp.webp)

## Sumur Directional dan Horizontal

Kabel ESP bisa terjepit saat rangkaian duduk di lekukan bawah sumur. Kurangi risiko ini dengan mengetahui **azimuth** sumur (arah ujung sumur terhadap utara, diukur searah jarum jam) sehingga posisi kabel bisa digeser. Contoh: sumur dengan inklinasi maksimum 38° dan azimuth 85° berarti ujung sumur mengarah kira-kira ke timur.

## Manajemen Sumur Berdasarkan GOR

Sumur dengan GOR tinggi (1.000 scf/stb atau lebih) atau sumur gas wajib memakai mud gas separator dan flare stack / vent dengan risk assessment khusus.

| GOR (scf/stb) | Risk assessment | Mud gas separator dan flare / vent | Sirkulasi malam hari |
|---|---|---|---|
| Kurang dari 100 | Generik | Tidak dibutuhkan | Boleh |
| 100 sampai kurang dari 1.000 | Generik | Wajib untuk lapangan tertentu yang ditetapkan dan semua sumur gas | Boleh |
| 1.000 atau lebih | Khusus, dibuat completion engineer | Wajib | Tidak boleh |

## Identifikasi Material Asing pada Rangkaian ESP

Ciri scale, pasir, debris, dan congeal ada di artikel General Knowledge **Sand Control & Clean Out Sand**. Program routine service light oil memberi pilihan opsional untuk running casing scraper, mule shoe, open end, dan sirkulasi, tergantung temuan saat pompa dicabut.

| Riwayat scraper / clean out terakhir | Diwajibkan program | Ada temuan saat pulling ESP | Lakukan scraper / clean out |
|---|---|---|---|
| Berapa pun | Ya | Ya | Ya |
| Berapa pun | Tidak | Ya | Ya |
| Berapa pun | Tidak | Tidak | Tidak |
| 6 bulan atau kurang | Ya | Tidak | Tidak |
| Lebih dari 6 bulan | Ya | Tidak | Ya |

## Rod-Driven PCP dengan Kabel Sensor Downhole

Pengetesan tubing hanger wajib dilakukan meski ada kabel sensor. Prosedur yang disepakati dengan penyedia pompa:

1. Tubing hanger PCP dilengkapi fitting (misalnya Swagelok) di bawahnya yang bisa menahan tekanan saat tes.
2. Jarak tubing hanger ke annular BOP sekitar 6 ft (1,8 m), sehingga ruang kerja sempit.
3. Ujung kabel ditutup plug dari penyedia pompa sebelum tes.
4. Sebelum mendudukkan tubing hanger, kencangkan fitting dan gulung kabel mengelilingi tubing atau nipple di atas tubing hanger dengan hati-hati.
5. Dudukkan tubing hanger, lalu tes sesuai checklist.

![Tubing hanger PCP dengan lubang untuk kabel sensor](/handbook-images/tubing-hanger-pcp.webp)

![Cover plug untuk kabel downhole PCP](/handbook-images/cover-plug-kabel-pcp.webp)

## Pump Spacing SRP di Lapangan Light Oil

Sumur SRP di light oil umumnya lebih dalam dari 1.000 ft, sehingga spacing harus mengkompensasi pemanjangan sucker rod akibat beratnya sendiri dan temperatur.

1. Sampai kedalaman 1.000 ft: **1 inch per 100 ft**.
2. Lebih dari 1.000 ft: **0,3 inch per 100 ft**.
3. Contoh sumur 1.500 ft: (1.000 × 1/100) + (500 × 0,3/100) = 10 + 1,5 = **11,5 inch**.
