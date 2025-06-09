# Payslip Management System

Aplikasi ini digunakan untuk mengelola data kehadiran, lembur, reimburse, dan proses payroll karyawan secara otomatis dengan sistem berbasis web.

## Fitur Utama

- Input dan tracking absensi karyawan  
- Perhitungan lembur otomatis  
- Pengelolaan reimburse dan klaim karyawan  
- Generate payslip dalam format PDF  
- Otentikasi pengguna menggunakan JWT untuk keamanan  
- Dashboard monitoring dan laporan lengkap  

## Instalasi

1. Clone repository ini:

```bash
git clone https://github.com/cahyoaa/payslip.git
cd payslip
```

2. Install dependencies (sesuaikan dengan teknologi yang kamu pakai, contoh npm):

```bash
npm install
```

3. Konfigurasi database di file `.env` sesuai pengaturan PostgreSQL kamu.

4. Jalankan aplikasi:

```bash
npm start
```

## Cara Penggunaan

- Buka browser dan akses `http://localhost:3000` (atau port sesuai konfigurasi)  
- Login menggunakan akun yang sudah terdaftar  
- Kelola data absensi, lembur, reimburse, dan generate payslip sesuai kebutuhan  

## Kontribusi

Jika kamu ingin berkontribusi:  
1. Fork repository ini  
2. Buat branch baru untuk fitur/bugfix:  
   ```bash
   git checkout -b fitur-baru
   ```  
3. Commit perubahan kamu:  
   ```bash
   git commit -m "Tambah fitur baru"
   ```  
4. Push branch ke remote:  
   ```bash
   git push origin fitur-baru
   ```  
5. Buat Pull Request melalui GitHub

## Lisensi

Project ini dilisensikan di bawah MIT License. Lihat file [LICENSE](LICENSE) untuk detail.
