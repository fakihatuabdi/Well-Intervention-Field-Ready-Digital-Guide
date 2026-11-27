---
title: Heavy Oil Best Practice
slug: zr-heavy-oil-best-practice
position: 6
summary: Initial cooling down sumur heavy oil, metode bullhead, dan penanganan sumur dengan indikasi plugging atau congeal.
---

Best practice heavy oil dibagi ke beberapa artikel:

- **Heavy Oil Best Practice** (artikel ini): initial cooling down, bullhead, dan sumur plugging / congeal.
- **Heavy Oil: Tubing Leak, Stuck & Fishing**
- **Heavy Oil: Sand Clean Out & Pump Set Depth**
- **Heavy Oil: Pump Installation & Test Pumping**
- **Heavy Oil: Kill Fluid, Gas & Suspend Well**

## Kapan Sumur Tidak Bisa Dikerjakan Rig Routine Service

Bila sumur membutuhkan kill fluid yang harus **dibuat (mixing) di lokasi**, suspend sumur dan laporkan ke atasan, completion engineer, dan scheduler. Rig routine service tidak dirancang untuk membuat kill fluid di lokasi.

## Persiapan Sebelum Initial Cooling Down

Bila menemukan kendala di tahap ini, diskusikan dengan atasan. Pastikan rig memiliki standpipe atau mud manifold dan layout pemompaan / bleed off.

1. Siapkan line-up agar bisa cek tekanan, bleed off, dan memompa melalui tubing maupun annulus.
2. Pasang pressure gauge di sample cock.
3. Hubungkan casing valve pertama ke manifold sebagai jalur bleed, dan casing valve kedua ke mud pump.
4. Hubungkan tubing melalui master valve di jalur produksi.
5. Pressure test semua jalur selama 10 menit. Untuk sumur SRP: **650 psi**.
6. Pastikan mud tank penuh. Siapkan vacuum truck bila tangki atau air di lokasi terbatas.

## Aturan Initial Cooling Down

1. Semua aliran dari dan ke sumur lewat manifold dan masuk ke tangki. Tidak ada aliran yang dibuang ke udara terbuka.
2. Cek SICP dan SITP di awal. Bila keduanya **0 psi**, buka casing valve dan flow check selama 30 menit. Bila tidak 0 psi, langsung cooling down dengan metode bullhead.
3. Setiap observasi berlangsung minimal 30 menit. Lakukan bleed off untuk mengecek tekanan terkurung.
4. Batas volume awal adalah **100 bbl air**:
   - Bila sumur mati dengan 100 bbl atau kurang, siapkan **260 bbl** air sebelum melanjutkan.
   - Bila sumur mati dengan lebih dari 100 bbl, siapkan **360 bbl** air sebelum melanjutkan.
5. Kapasitas rig menentukan pembatasan ini. Contoh: dengan satu tangki 200 bbl, butuh tambahan satu vacuum truck penuh (sekitar 60 bbl) untuk 260 bbl, dan minimal tiga vacuum truck (sekitar 180 bbl) untuk 360 bbl. Bila 360 bbl tidak bisa disiapkan, suspend sumur dengan alasan killing problem.
6. **Tanpa dry gas atau steam**: bila sudah memompa 100 bbl atau 400 bbl (100 bbl awal ditambah tiga tahap dengan laju berbeda) dan tekanan tidak turun, suspend pekerjaan dan beri tahu atasan, engineer, dan scheduler. Bila setelah 400 bbl tekanan turun sampai 25% atau kurang dari tekanan awal dengan tren menurun tetapi belum 0 psi, beri tahu atasan untuk memutuskan melanjutkan cooling down.
7. **Dengan dry gas atau steam**: volume maksimum 100 bbl (untuk kapasitas air 260 bbl) atau 200 bbl (untuk kapasitas 360 bbl), dengan laju pompa maksimum yang diizinkan (biasanya 6–7 bpm).

**Jangan pernah membuka wellhead** bila cooling down belum berhasil atau SICP dan SITP belum nol selama minimal 30 menit. Bila pekerjaan tetap dilanjutkan dalam kondisi itu, kenaikan tekanan akan diperlakukan sebagai **kejadian well control**.

## Metode Bullhead di Heavy Oil

Prosedur dan rumus umum bullhead ada di artikel General Knowledge **Well Killing & Kill Fluid**. Untuk heavy oil:

- Hitung tekanan pemompaan maksimum, volume minimum, dan konversi volume ke waktu (rig routine service umumnya tidak punya stroke counter). Gunakan lembar perhitungan resmi dari completion engineer.
- Gradien rekahan formasi mengacu pada data resmi area masing-masing.
- Sumur loss: pompakan minimal 2× volume lubang (maksimal 100 bbl pada pemompaan pertama). Sumur yang bisa menahan kolom fluida: minimal 1,1× volume lubang.
- Sumur loss yang memiliki tekanan tetapi saat bullhead tekanan terbaca 0 psi: pompakan dengan laju maksimum pompa.

## Sumur dengan Indikasi Plugging / Congeal

Waspadai sumur dengan ciri: minyak berat, injeksi uap yang belum matang, dan riwayat pump stuck. Ciri ini tidak otomatis berarti plugging, sehingga perlu dikonfirmasi.

**Sumur loss:** lakukan initial killing sesuai prosedur dan catat apakah ada volume yang masuk ke formasi.

- Bila ada laju masuk ke formasi, killing dapat dilakukan tanpa masalah.
- Bila tidak ada laju, tekanan cepat naik, atau level fluida dekat permukaan, ikuti prosedur sumur penuh.

**Sumur penuh:** lakukan initial killing, buka production valve, lalu reverse circulation dari annulus sampai berat fluida masuk sama dengan keluar (konfirmasi dengan mud balance). Bila tercapai, sumur tidak bermasalah. Bila tidak ada aliran lewat tubing, kemungkinan besar ada congeal / plugging.

**Prosedur bila dicurigai plugging:**

1. Pressure test tubing untuk mengecek kebocoran.
2. Coba flush down lewat tubing sesuai jenis pompa:
   - *Tubing pump*: setelah pressure test, pancing standing valve, angkat plunger ke atas barrel, flush down dengan air formasi 1× volume tubing. Pasang kembali standing valve **hanya bila** pressure test tubing sebelumnya gagal.
   - *Insert pump*: unlatch insert pump dari seating nipple, lalu flush down 1× volume tubing.
   - *Tubing pump on-off tool*: flush down lewat tubing tidak mungkin, tetapi efek swabbing juga kecil karena plunger tidak bisa digerakkan.
3. Bila standing valve tidak terpancing atau insert pump tidak bisa di-unlatch: tetap waspada, cabut rod perlahan, dan pantau lubang secara berkala (misalnya tiap 1–2 stand).

**Perkuat barrier sisi tubing saat mencabut rod dari WPF:**

1. Angkat tubing hanger sampai di atas spider slip, pasang slip di bawahnya.
2. Pasang production tee, sambungkan ke hose menuju return tank, lalu pasang rod BOPE di atas tee.
3. Cabut sucker rod dengan rod BOPE terpasang.
4. Bila terjadi well control: jatuhkan rangkaian rod lalu shut-in dengan FOSV di atas rod BOPE. Bila rod tidak bisa dijatuhkan, buka production valve ke return tank, tutup rod BOPE, potong sucker rod, lalu shut-in dengan FOSV.

**Catatan untuk tubing pump 3-3/4":**

- Plunger tidak dapat melewati crossover di bawah tubing hanger, dan tubing harus 4-1/2" NUE.
- Cabut rod di WPF setelah N/U BOP. Bongkar pup joint tubing hanger sampai bertemu tubing 4-1/2" NUE, lalu pasang pumping tee dan rod BOP dengan crossover yang sesuai.
- Sebelum membuka sambungan terakhir di atas plunger, pastikan SITP/SICP = 0/0 psi.
- Bila terjadi aliran saat membuka sambungan, pasang kembali pumping tee dan rod BOPE lalu ikuti prosedur shut-in, atau bagi tugas kru: satu fokus mengangkat pumping tee dan rod BOPE, satu fokus menutup tubing dengan FOSV.
