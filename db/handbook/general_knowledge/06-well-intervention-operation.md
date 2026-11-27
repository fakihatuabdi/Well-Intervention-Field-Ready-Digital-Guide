---
title: Well Intervention Operation
slug: gk-well-intervention-operation
position: 6
summary: Urutan kerja umum penggantian pompa sucker rod dan praktik baik saat mencabut dan memasang rangkaian.
---

## Urutan Kerja Umum Penggantian Pompa SRP

1. Move in, rig up (MIRU).
2. Initial killing / cooling down sumur sampai SICP dan SITP nol dan tidak ada aliran.
3. Lepas polished rod dan stuffing box, cabut rangkaian sucker rod (plunger atau insert pump ikut tercabut).
4. N/D production tree, N/U BOPE dan working platform, lalu pressure test BOPE.
5. Lepas tubing hanger, cek top of sand (TOS) bila diperlukan.
6. Cabut rangkaian tubing (tubing pump ikut tercabut).
7. Clean out sand bila diperlukan.
8. Masukkan rangkaian tubing dengan pompa baru sampai pump setting depth, dudukkan dan tes tubing hanger.
9. N/D BOPE, N/U production tree.
10. Masukkan plunger dan sucker rod, lakukan pump spacing.
11. Test pumping, pasang kembali jalur produksi, rig down, move out (RDMO).

Untuk insert pump, tubing tidak selalu perlu dicabut. Cukup cabut dan masukkan kembali rangkaian sucker rod bersama insert pump, selama kondisi sumur dan seating nipple memungkinkan.

## Pump Spacing

Pump spacing adalah jarak antara travelling valve dan standing valve saat plunger berada di posisi terbawah. Spacing memengaruhi **compression ratio** pompa.

- Spacing terlalu besar: volume mati (unswept volume) membesar, compression ratio turun, pompa sulit mengeluarkan fluida dan rentan gas lock.
- Spacing terlalu kecil: travelling valve bisa menabrak standing valve (tapping) dan merusak pompa.

Langkah umum menentukan spacing:

1. Catat berat pick up (P/U) dan slack off (S/O) rangkaian plunger sebagai acuan.
2. Turunkan sampai plunger menyentuh standing valve dengan beban sedikit di atas berat S/O.
3. Angkat perlahan sampai berat kembali ke P/U awal, beri tanda di rod.
4. Angkat lagi sesuai spacing yang ditentukan program, lalu kencangkan clamp polished rod.

Pada sumur dalam, sucker rod memanjang karena beratnya sendiri dan pengaruh temperatur, sehingga spacing perlu dikompensasi sesuai kedalaman.

![Prosedur pump spacing tubing pump](/handbook-images/prosedur-pump-spacing.webp)

## Mule Shoe di Bawah Pompa

Mule shoe adalah potongan tubing dengan ujung miring yang dipasang di bawah pompa. Manfaatnya:

- Ujung runcing lebih mudah menembus sand fill.
- Pompa bisa langsung dipakai untuk clean out sand sehingga waktu kerja lebih singkat.
- Membantu mengarahkan rangkaian masuk ke liner pada sumur berarah.
- Melindungi pompa saat dimasukkan ke sumur.

![Penggunaan tubing dan mule shoe di bawah seating nipple](/handbook-images/mule-shoe-di-bawah-seating-nipple.webp)

## Pencegahan Unscrew Sucker Rod

Unscrew adalah lepasnya sambungan sucker rod di dalam sumur, biasanya di sambungan pin-box. Penyebab umum: torsi pengencangan tidak tepat dan coupling yang aus karena bergesekan dengan tubing.

**Rotasi sambungan.** Pencabutan per stand (dua joint) mempercepat pekerjaan, tetapi sambungan di tengah stand tidak pernah dibuka dan dicek. Solusinya: lepas satu joint paling atas dan pindahkan ke posisi lain saat memasukkan kembali, sehingga sambungan yang dibuka berganti di setiap pekerjaan. Praktik ini berlaku juga untuk tubing.

**Torsi sesuai standar.** Gunakan rod tong dengan torsi sesuai ukuran sucker rod, dan verifikasi dengan circumferential displacement (CD) mengacu ke API RP 11BR.

| Ukuran rod | Make-up torque (ft-lbs) | CD rod baru grade D | CD rod bekas (rerun) |
|---|---|---|---|
| 3/4" | 430 | 16/64" – 31/64" | 12/64" – 30/64" |
| 7/8" | 675 | 22/64" – 34/64" | 18/64" – 32/64" |
| 1" | 1010 | 28/64" – 43/64" | 24/64" – 40/64" |

**Hand-tight untuk polished rod dan sinker bar.** Rod tong bisa merusak body polished rod. Kencangkan dengan tangan sampai shoulder bertemu, beri garis penanda, lalu putar lagi sampai garis membentuk sudut sekitar 90° (rod 3/4" dan 7/8") atau 180° (rod 1").

![Rotasi sucker rod pada tiap well service](/handbook-images/rotasi-sucker-rod.webp)

![Garis lurus penanda posisi awal sebelum sucker rod dikencangkan](/handbook-images/penguncian-rod-posisi-awal.webp)

![Pergeseran garis setelah sucker rod dikencangkan (circumferential displacement)](/handbook-images/penguncian-rod-setelah-kencang.webp)

## Posisi Plunger Saat Meninggalkan Sumur

Saat test pumping, pasir bisa ikut masuk ke tubing dan mengendap di atas plunger selama sumur menunggu dinyalakan. Bila gerakan pertama plunger ke atas, pasir dapat masuk ke celah plunger dan barrel lalu menjepit plunger.

Praktik baik: tinggalkan horse head di posisi **upstroke** (counterweight di titik terbawah), sehingga gerakan pertama plunger saat POP adalah **turun**. Fluida dari bawah plunger akan membuyarkan pasir yang mengendap.

![Posisi plunger dan pasir yang terperangkap saat pumping unit berhenti](/handbook-images/posisi-plunger-temperatur.webp)

## Pengetesan Rod BOP

Rod BOP sesuai ukuran sucker rod memungkinkan pencabutan dan pemasangan sucker rod dengan dua barrier: hidrostatik dan mekanis. Prinsip umumnya:

- Tes rod BOP terhadap tekanan yang dipersyaratkan (umumnya MASP + margin) selama beberapa menit sebelum memasukkan plunger, dan catat hasilnya.
- Saat mencabut: gantung rod, pasang rod BOP tambahan dengan rubber yang sesuai, tutup, lalu tes melawan standing valve melalui sample cock.
- Saat memasukkan dari atas WPF: pasang pumping tee di atas tubing, stab in rod BOP, masukkan plunger satu joint, tutup dan tes melalui pumping tee.
- Bila pompa belum memiliki standing valve, gunakan FOSV tertutup di atas tubing sebagai titik tes.
- Bila pengetesan tidak bisa dilakukan, gunakan mitigasi yang sudah disetujui melalui risk assessment dan prosedur rig.
