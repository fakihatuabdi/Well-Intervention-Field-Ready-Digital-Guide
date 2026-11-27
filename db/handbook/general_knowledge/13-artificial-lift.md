---
title: Artificial Lift
slug: gk-artificial-lift
position: 13
summary: Prinsip kerja Sucker Rod Pump, Electric Submersible Pump, dan Progressive Cavity Pump, beserta komponen utamanya.
---

Artificial lift dipakai ketika tekanan reservoir tidak cukup untuk mengangkat fluida ke permukaan. Tiga jenis yang paling umum di pekerjaan routine service adalah SRP, ESP, dan PCP.

## Sucker Rod Pump (SRP)

**Peralatan permukaan:** prime mover (motor), gear reducer (mengubah putaran cepat-torsi rendah menjadi putaran lambat-torsi tinggi), dan pumping unit. Pumping unit bisa mekanis (MPU) atau hidraulik (HPU).

**Peralatan bawah permukaan:** tubing, sucker rod, dan pompa.

Rangkaian dari atas ke bawah: bridle di horse head, carrier bar, polished rod yang melewati stuffing box (membentuk seal), sucker rod dan pony rod, lalu pompa.

![Skematik tipikal pumping unit dan sumur minyak](/handbook-images/skematik-pumping-unit.webp)

![Skematik hydraulic pumping unit](/handbook-images/hydraulic-pumping-unit.webp)

### Tubing Pump dan Insert Pump

| Aspek | Tubing Pump | Insert Pump (Rod Pump) |
|---|---|---|
| Posisi barrel | Menjadi bagian dari rangkaian tubing | Dimasukkan ke dalam tubing bersama sucker rod, duduk di seating nipple |
| Ukuran plunger | Lebih besar, volume pompa lebih besar | Lebih kecil |
| Penggantian | Harus mencabut tubing | Cukup mencabut sucker rod (bila seating nipple cocok) |
| Beban angkat | Lebih besar | Lebih ringan |

![Tubing pump dan insert pump](/handbook-images/tubing-pump-vs-insert-pump.webp)

![Bagian-bagian insert pump](/handbook-images/bagian-insert-pump.webp)

### Komponen Rangkaian Rod

- **Polished rod**: rod paling atas yang bergerak naik-turun melalui stuffing box.
- **Pony rod**: rod pendek untuk menyesuaikan panjang rangkaian.
- **Shear coupling**: titik lemah yang sengaja dipasang di atas plunger. Bila pompa terjepit, shear coupling diputus sesuai rating-nya agar tidak perlu mencabut tubing dan rod bersamaan.
- **Sinker bar**: rod berat yang menjaga rangkaian tetap lurus dan dalam kondisi tension, mencegah buckling. Pada sumur vertikal dipasang di bawah (di atas plunger).

### Compression Ratio

**CR = (Swept volume + Unswept volume) / Unswept volume**

CR yang tinggi membantu pompa membuka valve dan mengurangi risiko gas lock. Unswept volume sangat dipengaruhi pump spacing, sehingga spacing yang tepat penting untuk CR yang optimal.

![Ilustrasi compression ratio pada tubing pump](/handbook-images/compression-ratio.webp)

### Pompa Khusus untuk Sumur Berpasir

| Jenis | Prinsip |
|---|---|
| Special clearance | Celah plunger-barrel lebih lebar agar pasir halus bisa lewat |
| Stroke-thru | Plunger keluar melewati ujung barrel saat stroke sehingga membersihkan pasir |
| Short plunger | Plunger lebih pendek untuk mengurangi gesekan, dengan konsekuensi slippage lebih besar |
| Special cage | Cage dengan clearance ketat agar bola valve duduk baik pada inklinasi tinggi |
| Tapered plunger | Ujung plunger dimodifikasi agar pasir tidak mengendap di atas plunger |
| Double travelling valve | Dua travelling valve untuk sumur berpasir |
| Sand trapper / scraper | Aksesori di atas atau bawah plunger untuk menampung dan mengikis pasir |
| On-off tool | Plunger dimasukkan bersama barrel, lalu rangkaian rod disambungkan di dalam sumur. Memungkinkan pompa besar dengan tubing yang lebih kecil. |

**Pump slippage** adalah fluida yang lolos di antara plunger dan barrel. Slippage sedikit diperlukan untuk pelumasan (umumnya beberapa persen produksi). Terlalu sedikit merusak pompa, terlalu banyak berarti kehilangan produksi.

![Tubing pump special clearance](/handbook-images/special-clearance.webp)

![Tubing pump reguler dan stroke-thru](/handbook-images/stroke-thru.webp)

![Short plunger dibandingkan regular plunger](/handbook-images/short-plunger.webp)

![API conventional dan Farr plunger](/handbook-images/farr-plunger.webp)

![Tubing pump reguler dan double travelling valve (DTV)](/handbook-images/double-travelling-valve.webp)

![Plunger dengan sand trapper dan scraper](/handbook-images/sand-trapper-scraper.webp)

![Skematik sand trapper](/handbook-images/skematik-sand-trapper.webp)

![Regular plunger dibandingkan plunger SandDozer](/handbook-images/sanddozer.webp)

## Electric Submersible Pump (ESP)

ESP adalah pompa sentrifugal bertingkat (multistage) dengan motor listrik yang seluruhnya ditenggelamkan di dalam fluida. Cocok untuk laju alir sedang sampai tinggi.

Komponen dari bawah ke atas:

| Komponen | Fungsi |
|---|---|
| **Motor** | Motor induksi 3 fasa berisi oli dielektrik. Terdiri dari rotor (berputar) dan stator (diam). |
| **Protector (seal section)** | Mencegah fluida sumur masuk ke motor, menyeimbangkan tekanan motor dan annulus, menahan thrust load pompa, dan menampung ekspansi oli. |
| **Intake / gas separator** | Jalan masuk fluida. Bisa standard intake, static gas separator, atau rotary gas separator. |
| **Gas handler** | Memampatkan gas menjadi gelembung kecil agar tidak terjadi gas lock (tidak memisahkan gas). |
| **Pompa** | Tiap stage terdiri dari impeller (memberi energi kecepatan) dan diffuser (mengubah kecepatan menjadi tekanan). |
| **Kabel** | Kabel daya dan motor lead extension (MLE). |

![Tipikal komplesi dengan ESP](/handbook-images/komplesi-esp.webp)

![Bagian-bagian utama ESP](/handbook-images/bagian-esp.webp)

![Gambaran singkat sistem ESP](/handbook-images/sistem-esp.webp)

![Impeller dan diffuser pompa sentrifugal multistage](/handbook-images/impeller-diffuser.webp)

![Komponen pompa ESP](/handbook-images/rangkaian-pompa-esp.webp)

![Konstruksi motor ESP](/handbook-images/motor-esp.webp)

![Intake ESP](/handbook-images/intake-esp.webp)

![Prinsip kerja advanced gas handler](/handbook-images/prinsip-gas-handler.webp)

![Gas handler](/handbook-images/gas-handler.webp)

![Peralatan permukaan ESP](/handbook-images/surface-equipment-esp-1.webp)

![Peralatan permukaan ESP (switchboard dan transformer)](/handbook-images/surface-equipment-esp-2.webp)

### Kabel ESP

- **Round**: dipakai bila ruang annulus cukup.
- **Flat**: dipakai bila ruang annulus sempit.
- Komponen: konduktor tembaga, isolasi, jaket atau lead sheath, dan armor logam pelindung.
- Ukuran konduktor memakai sistem **AWG**. Makin besar angkanya, makin kecil kabelnya. Ukuran yang umum di ESP adalah 1, 2, 4, dan 6.
- Penyambungan kabel (splicing) dipakai untuk memperpanjang atau memperbaiki kabel.

![Konstruksi kabel ESP round dan flat](/handbook-images/konstruksi-kabel-esp.webp)

![Lapisan kabel ESP](/handbook-images/kabel-esp-1.webp)

![Lapisan kabel ESP](/handbook-images/kabel-esp-2.webp)

![Lapisan kabel ESP flat](/handbook-images/kabel-esp-3.webp)

### Megger Test

Megger mengukur **resistansi isolasi** kabel dan motor untuk memastikan kondisi kelistrikannya baik. Prinsipnya mengikuti Hukum Ohm:

**E = I × R** (E = tegangan dalam volt, I = arus dalam ampere, R = resistansi dalam ohm)

Isolasi yang baik memiliki resistansi yang sangat tinggi. Resistansi turun karena temperatur, kelembapan, kotoran, kerusakan mekanis, dan getaran. Praktik umum:

- Baca kabel dengan megger dan multitester secara berkala saat menurunkan rangkaian (misalnya setiap 20 joint).
- Nilai isolasi motor yang baik umumnya sangat tinggi (orde ribuan megaohm), dan nilai tiap fasa harus seimbang.

![Analogi aliran air dan arus listrik](/handbook-images/aliran-air-vs-listrik.webp)

![Cara membaca resistansi insulasi dengan megger](/handbook-images/cara-megger.webp)

![Megger (kiri) dan multitester (kanan)](/handbook-images/megger-multitester.webp)

## Progressive Cavity Pump (PCP)

PCP adalah pompa positive displacement berbasis putaran. Rotor berbentuk heliks berputar di dalam stator elastomer, membentuk rongga yang bergerak naik membawa fluida.

- Pada **rod-driven PCP**, motor ada di permukaan dan putaran diteruskan lewat sucker rod.
- Cocok untuk fluida kental dan fluida yang mengandung pasir.
- Saat bongkar pasang drive head biasanya dibutuhkan dua alat angkat, dan perlu koordinasi dengan penyedia pompa untuk kabel dan spacing rotor.

![Tipikal komplesi dengan progressive cavity pump](/handbook-images/komplesi-pcp.webp)

## Memilih Jenis Artificial Lift

| Jenis | Kelebihan | Keterbatasan |
|---|---|---|
| SRP | Sederhana, tahan padatan, umum dipakai | Terbatas pada sumur dalam, GOR tinggi, dan diameter tubing kecil. Footprint besar. |
| ESP | Laju alir tinggi, footprint permukaan kecil | Sensitif terhadap gas, pasir, dan temperatur. Butuh suplai listrik andal. |
| PCP | Baik untuk minyak kental dan berpasir | Elastomer stator sensitif terhadap temperatur dan jenis fluida |
