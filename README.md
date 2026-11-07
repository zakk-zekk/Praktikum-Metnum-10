# Praktikum 10 – Persamaan Diferensial Biasa (Metode Numerik)

Penyelesaian persamaan diferensial biasa orde satu dengan nilai awal menggunakan tiga metode numerik di GNU Octave: **Euler**, **Heun (Runge-Kutta orde-2)**, dan **Runge-Kutta orde-4 (RK4)**, lalu dibandingkan dengan solusi eksak.

**Nama:** Febrian Zaki Hidayatulloh
**NIM:** L0325045
**Program Studi:** Informatika, Fakultas Teknologi Informasi dan Sains Data, Universitas Sebelas Maret

## Soal

$$\frac{dy}{dx} = \frac{4x^3 - 2x + 1}{2 + y}, \qquad y(0) = 1$$

Tentukan $y(2)$ dengan $N = 15$ langkah (ukuran langkah $h = \frac{2-0}{15} \approx 0{,}133333$).

## Solusi Eksak

Persamaan dapat dipisahkan variabelnya:

$$(2+y)\,dy = (4x^3 - 2x + 1)\,dx \;\Rightarrow\; (y+2)^2 = 2x^4 - 2x^2 + 2x + 9$$

$$y(x) = -2 + \sqrt{2x^4 - 2x^2 + 2x + 9}, \qquad y(2) = -2 + \sqrt{37} \approx 4{,}082763$$

## Metode yang Digunakan

| Metode | Rumus | Evaluasi fungsi per langkah |
|---|---|---|
| Euler | $y_{i+1} = y_i + h\,f(x_i, y_i)$ | 1 |
| Heun (RK-2) | $y_{i+1} = y_i + \frac{h}{2}(k_1 + k_2)$ | 2 |
| Runge-Kutta orde-4 | $y_{i+1} = y_i + \frac{h}{6}(k_1 + 2k_2 + 2k_3 + k_4)$ | 4 |

## Hasil (N = 15)

| Metode | y(2) hampiran | Galat absolut | Galat relatif (%) |
|---|---|---|---|
| Eksak | 4,082763 | – | – |
| Euler | 3,873692 | 0,209071 | 5,1208 |
| Heun (RK-2) | 4,095312 | 0,012549 | 0,3074 |
| Runge-Kutta orde-4 | 4,082773 | 0,000011 | 0,0003 |

Semakin tinggi orde metode, semakin kecil galat pada ukuran langkah yang sama. RK4 paling teliti, sedangkan Euler paling sederhana tetapi paling besar galatnya.

## Struktur Program

File: `PMN010_L0325045_FebrianZakiHidayatulloh.m`

| Fungsi | Keterangan |
|---|---|
| `fxy(x, y)` | Ruas kanan persamaan diferensial $f(x,y)$ |
| `solusi_eksak(x)` | Solusi analitik, dipakai sebagai pembanding dan untuk grafik |
| `metode_euler(a, y0, b, N)` | Metode Euler, mengembalikan tabel iterasi dan nilai y akhir |
| `metode_heun(a, y0, b, N)` | Metode Heun (RK-2) |
| `metode_rk4(a, y0, b, N)` | Metode Runge-Kutta orde-4 |

Program utama menampilkan tiga tabel iterasi, tabel perbandingan dengan solusi eksak (galat absolut dan relatif), serta dua grafik:

1. Solusi eksak dan hampiran numerik ketiga metode.
2. Galat absolut tiap metode terhadap x (skala logaritmik).

## Cara Menjalankan

Program ditulis untuk **GNU Octave** (file skrip dengan beberapa fungsi, diawali `1;`). Fungsi yang didefinisikan sebelum program utama di dalam file skrip seperti ini tidak dapat dijalankan langsung di MATLAB tanpa penyesuaian.

1. Pasang [GNU Octave](https://octave.org/download).
2. Buka Octave, pindah ke folder yang berisi file ini.
3. Jalankan:

   ```octave
   PMN010_L0325045_FebrianZakiHidayatulloh
   ```

   atau dari terminal:

   ```bash
   octave PMN010_L0325045_FebrianZakiHidayatulloh.m
   ```

Parameter dapat diubah di bagian program utama (`a`, `y0`, `b`, `N`).
