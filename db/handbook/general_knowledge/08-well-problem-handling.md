---
title: Well Problem Handling
slug: gk-well-problem-handling
position: 8
summary: Penanganan masalah umum saat intervensi sumur, dari kebocoran tubing dan pipa terjepit sampai suspend sumur.
---

## Mengelompokkan Masalah

Sebelum mencari solusi, tentukan dulu kategori masalahnya agar keputusan tepat dan dapat dipertanggungjawabkan:

- **Desain program**: desain komplesi atau ukuran pompa tidak sesuai kondisi sumur.
- **Operasi**: masalah teknis di sumur, misalnya pipa terjepit atau sumur tidak mati.
- **Logistik dan lokasi**: material tidak tersedia, akses lokasi, atau jadwal.

Setiap keputusan yang menyimpang dari program harus mengikuti matriks kewenangan yang berlaku, dan dicatat lengkap: kondisi dan data aktual, dasar keputusan, opsi yang dipilih, serta siapa yang menyetujui dan kapan.

## Deteksi Awal Kebocoran Tubing

Kondisi tubing menurun seiring waktu dan kebocoran sering tertutup minyak kental sehingga sulit dilihat. Cara mendeteksinya:

1. Setelah cooling down, lakukan pressure test tubing (misalnya 250–300 psi selama 5 menit) dan catat apakah ada penurunan tekanan.
2. Saat mencabut tubing dengan standing valve yang masih baik (wet pull), perhatikan ketinggian cairan di dalam tubing. Batas cairan menunjukkan kedalaman tubing yang bocor.
3. Untuk insert pump, gunakan plug (bull plug atau plug pada seating nipple) lalu tes bertahap per beberapa stand untuk menemukan joint yang bocor.
4. Saat memasukkan tubing pump, isi tubing dan cek level cairan per beberapa stand.

Bila kebocoran ada di rangkaian tubing, clean out sand menjadi tidak efektif karena prinsip U-tube terganggu.

## Overpull dan Tubing Terjepit

Overpull adalah tarikan **di atas berat rangkaian**. Bedakan dengan tension total yang terbaca di weight indicator.

Prinsip menentukan batas overpull:

- Jangan melebihi kapasitas tarik rig yang tercatat di sertifikat kelayakan.
- Batasi pada sekitar **80% dari yield strength koneksi terlemah** di rangkaian yang diangkat.
- Perhatikan juga komponen terlemah di atas tubing hanger (landing joint, crossover, FOSV).

Bila tubing hanger tidak terangkat sama sekali, curigai titik jepit di tubing hanger dan gunakan batas kekuatan komponen di atas tubing hanger. Lakukan overpull secara bertahap dan tahan di setiap tahap.

## Mechanical Back-off

Back-off adalah langkah terakhir untuk membebaskan sebagian rangkaian. Risikonya tinggi, sehingga pastikan:

1. Safety sling terpasang di lengan power tong sebagai penahan kedua.
2. Dies power tong dalam kondisi baik.
3. Power tong dioperasikan dengan remote dari jarak aman, dan tidak ada orang di atas WPF.
4. Swivel travelling block dapat berputar bebas untuk mengantisipasi torsi balik.
5. Tidak ada benda di mast yang berpotensi jatuh.
6. Risk assessment dan persetujuan atasan sudah ada.

Langkah umumnya: hitung berat rangkaian yang akan dilepas (dikoreksi buoyancy), set beban di weight indicator sesuai berat tersebut, lalu beri torsi kiri bertahap sampai sambungan terbuka. Hentikan dan eskalasi bila mencapai batas torsi maksimum.

**Faktor buoyancy** = 1 − (berat fluida dalam sumur, ppg / 65,5)

## Rangkaian Tertinggal di Sumur (Fish)

Bila tubing, pompa, atau tail tertinggal, coba **screw-in** beberapa kali dengan ulir yang dalam kondisi baik. Catat data berikut sebelum dan sesudah memancing:

1. Panjang fish dan top of fish (TOF).
2. Berat fish (dikoreksi buoyancy).
3. Jumlah putaran sampai fully engaged.
4. Berat rangkaian sebelum dan sesudah screw-in, untuk memastikan fish terpancing atau tidak.

## Gas Lock

Gas lock terjadi saat gas mengisi pump barrel. Saat downstroke gas hanya terkompresi dan tidak cukup kuat membuka travelling valve, sedangkan saat upstroke tekanan tidak cukup turun untuk membuka standing valve. Pompa tidak rusak, tetapi tidak memompa.

Tanda saat test pumping: tekanan permukaan naik saat upstroke tetapi turun saat downstroke. Solusinya adalah memisahkan gas sebelum masuk pompa, misalnya dengan **gas anchor (mud anchor)**.

## Sumur Plugging atau Congeal

Minyak berat yang mengental, clay, atau endapan lain dapat membuat prinsip U-tube tidak berlaku. Tekanan bisa terbaca nol padahal sebenarnya tersumbat. Waspadai sumur minyak berat, sumur dengan riwayat pompa terjepit, dan sumur yang responsnya tidak wajar.

Konfirmasi dengan sirkulasi balik (reverse circulation) sampai berat fluida masuk sama dengan keluar. Bila tidak ada aliran lewat tubing, kemungkinan besar ada plugging. Pada kondisi ini:

- Tarik sucker rod perlahan untuk mengurangi efek piston (swabbing).
- Pantau lubang secara berkala, misalnya setiap 1–2 stand.
- Siapkan barrier di sisi tubing: production tee ke tangki dan rod BOP terpasang, FOSV siap di lantai kerja.

## Suspend Sumur

Alasan umum sumur ditunda pengerjaannya:

1. **Stuck problem**: tubing string atau tubing hanger tidak bebas setelah overpull sesuai batas.
2. **Fishing problem**: masih ada rangkaian tertinggal di sumur.
3. **Killing problem**: sumur tidak bisa dimatikan (SICP atau SITP di atas nol).
4. **Well integrity problem**: casing bocor atau keropos, casing collapse, atau rangkaian tidak bisa masuk.
5. **Wellhead problem**: valve tidak berfungsi atau baut tidak bisa dibuka secara normal.

Sebelum meninggalkan sumur, pastikan dua barrier terverifikasi dan rangkaian tidak menahan overpull. Laporan harus lengkap: kedalaman TOF, jumlah dan ukuran rangkaian yang tertinggal, OD dan ID TOF, kondisi TOF, dan overpull maksimum yang sudah diberikan. Gunakan kalimat baku dan jangan disingkat, misalnya *"Job suspended due to tubing hanger stuck"*.

**Jumlah tubing untuk suspend sumur** dihitung dari gaya ke atas:

- F(up) = tekanan tertinggi (SICP atau MASP) × luas penampang.
- Dengan check valve di ujung tubing, luas penampang = π × ID casing² / 4.
- Panjang minimum tubing = F(up) / berat tubing per ft, lalu bulatkan ke atas sebagai faktor keamanan.
- Pastikan ujung tubing tidak overlap dengan fish di dalam sumur.
