---
title: Well Killing & Kill Fluid
slug: gk-well-killing-kill-fluid
position: 7
summary: Metode bullhead, perhitungan berat kill fluid, pengenceran brine, pengaruh temperatur, dan hole monitoring.
---

## Metode Bullhead

Bullhead adalah pemompaan fluida ke dalam sumur dalam keadaan shut-in untuk memaksa fluida formasi masuk kembali ke formasi.

Sebelum bullhead, hitung dulu:

- Berat (ppg) dan volume (bbl) kill fluid yang dibutuhkan.
- Tekanan permukaan maksimum agar formasi tidak pecah (berdasarkan gradien rekahan dan TVD).
- Volume minimum. Praktik umum: **minimal 2× volume lubang** bila sumur tidak bisa menahan kolom fluida (loss), dan **minimal 1,1× volume lubang** bila sumur bisa menahan kolom fluida.
- Konversi volume ke durasi pemompaan bila rig tidak punya stroke counter.

Prosedur umum:

1. Pastikan line-up dari tangki ke annulus melalui casing valve.
2. Lakukan perhitungan di atas.
3. Pressure test semua jalur.
4. Mulai pemompaan perlahan.
5. Setelah injektivitas didapat, naikkan laju tanpa melebihi batas tekanan permukaan.
6. Pantau dan catat tekanan serta volume selama pemompaan.
7. Hentikan setelah volume target tercapai.
8. Baca, catat, dan pantau SITP dan SICP.
9. Bila tekanan masih terbaca, analisis apakah karena tekanan terkurung (trapped pressure) atau sumur memang underbalanced.

**Tekanan permukaan maksimum.** Hitung pada top perforation dan bottom perforation, lalu pakai yang paling rendah (biasanya di top perforation). Pada komplesi open hole gravel pack, top perforation mengacu ke casing shoe.

## Rumus Berat Kill Fluid

Dengan asumsi annulus atau tubing sudah terisi air (8,33 ppg):

**Kill fluid (ppg) = SF + 8,33 + [Tekanan shut-in (psi) / (0,052 × TVD top perforation (ft))]**

- SF adalah safety factor, misalnya 0,5 ppg.
- Bullhead lewat tubing gunakan SITP, lewat annulus gunakan SICP.

## Pengenceran Brine (Material Balance)

Untuk mendapatkan brine dengan berat tertentu dari dua fluida:

**V1 × MW1 + V2 × MW2 = (V1 + V2) × MW3**

Contoh: membuat 300 bbl brine 9,5 ppg dari brine 10 ppg dan air 8,33 ppg.

1. V1 × 8,33 + V2 × 10 = 300 × 9,5
2. V1 + V2 = 300, sehingga V1 = 300 − V2
3. (300 − V2) × 8,33 + V2 × 10 = 2.850
4. Hasilnya V2 ≈ 210 bbl brine 10 ppg dan V1 ≈ 90 bbl air.

## Pengaruh Temperatur terhadap Berat Brine

Berat brine turun saat temperatur naik karena ekspansi termal. Gradien penurunan umum:

| Berat brine (ppg) | Penurunan berat (ppg/°F) |
|---|---|
| 8,4 – 9,0 | 0,0017 |
| 9,1 – 11,0 | 0,0025 |
| 11,1 – 14,5 | 0,0033 |
| 14,6 – 17,0 | 0,0040 |
| 17,1 – 19,2 | 0,0048 |

Contoh (CaCl₂): temperatur permukaan 75 °F, dasar sumur 225 °F, berat yang dibutuhkan 10,5 ppg.

- Rata-rata temperatur sumur = (75 + 225) / 2 = 150 °F
- Berat di permukaan = 10,5 + [(150 − 75) × 0,0033] = 10,5 + 0,2475 ≈ **10,8 ppg**

## Hole Monitoring dan Loss Rate

- **Hole monitoring**: jaga ketinggian fluida setiap saat dengan mengisi sumur secara berkala selama mencabut rangkaian, dan catat di trip sheet.
- **Menentukan loss rate**: isi sumur sampai penuh, tunggu sekitar 10 menit, isi kembali sampai penuh dan catat volumenya. Volume per satuan waktu itulah loss rate.
- **Sumur loss**: tentukan laju dan frekuensi pengisian yang membuat sumur tetap aman, lalu lanjutkan pengisian dengan pola tersebut sambil memantau. Penggunaan polymer atau LCM butuh persetujuan engineering.
- **Ketersediaan air**: pastikan vacuum truck tersedia. Bila sumur butuh pengisian besar dan waktu pengambilan air lama, minta tambahan unit atau lakukan risk assessment untuk menentukan langkah berikutnya.

## Operasi dengan Satu Barrier

Operasi satu barrier terjadi ketika hanya satu barrier yang bisa ditegakkan pada langkah tertentu, misalnya saat N/D tree dan N/U BOP pada sumur non-SRP. Untuk meningkatkan jaminan:

- Verifikasi tekanan sebelum melepas salah satu barrier.
- Pastikan volume fluida cukup sampai dua barrier bisa ditegakkan kembali.
- Siapkan safety joint (dan cable cutter pada sumur ESP) di lantai kerja.
- Siapkan line-up ke tangki sehingga aliran dapat dialihkan sebelum shut-in.
- Pasang tubing hanger lengkap dengan FOSV tertutup, tes tubing hanger, dan cek tekanan sebelum melepas FOSV.
