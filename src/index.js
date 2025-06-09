const express = require('express');
const { Pool } = require('pg');
const app = express();
const port = 3000;

app.use(express.json());

// Konfigurasi koneksi PostgreSQL
const pool = new Pool({
  user: 'payroll_user',      // ganti dengan username db kamu
  host: 'localhost',     // atau alamat server db
  database: 'payroll_db',    // ganti dengan nama database kamu
  password: '1',  // ganti dengan password db kamu
  port: 5432,            // biasanya 5432
});

// Route POST /login
app.post('/login', async (req, res) => {
  const { username, password } = req.body;

  try {
    // Contoh query: cek username dan password di tabel users
    const result = await pool.query(
      'SELECT * FROM users WHERE username = $1 AND password_hash = $2',
      [username, password]
    );

    if (result.rows.length > 0) {
      res.status(200).json({ message: 'Login berhasil!' });
    } else {
      res.status(401).json({ message: 'Username atau password salah' });
    }
  } catch (error) {
    console.error('Error saat query ke db:', error);
    res.status(500).json({ message: 'Terjadi kesalahan server' });
  }
});

app.get('/', (req, res) => {
  res.send('Server berjalan');
});

app.listen(port, () => {
  console.log(`Server berjalan di http://localhost:${port}`);
});

app.post('/attendance-period', async (req, res) => {
  const { start_date, end_date } = req.body;

  if (!start_date || !end_date) {
    return res.status(400).json({ message: 'start_date dan end_date wajib diisi' });
  }

  try {
    const result = await pool.query(
      `INSERT INTO attendance_periods (start_date, end_date) VALUES ($1, $2) RETURNING *`,
      [start_date, end_date]
    );
    res.status(201).json({ message: 'Attendance period berhasil ditambahkan', data: result.rows[0] });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Terjadi kesalahan server' });
  }
});

app.post('/attendances', async (req, res) => {
  const { user_id, date } = req.body;

  if (!user_id || !date) {
    return res.status(400).json({ message: 'user_id dan date wajib diisi' });
  }

  const submittedDate = new Date(date);
  const dayOfWeek = submittedDate.getUTCDay(); // 0 = Minggu, 6 = Sabtu

  if (dayOfWeek === 0 || dayOfWeek === 6) {
    return res.status(400).json({ message: 'Tidak boleh submit attendance di hari weekend' });
  }

  try {
    // Cari attendance_period yang mencakup tanggal ini
    const periodResult = await pool.query(
      `SELECT id FROM attendance_periods WHERE start_date <= $1 AND end_date >= $1`,
      [date]
    );

    if (periodResult.rows.length === 0) {
      return res.status(400).json({ message: 'Tanggal tidak termasuk dalam attendance period manapun' });
    }

    const attendance_period_id = periodResult.rows[0].id;

    // Cek apakah user sudah submit attendance di hari yang sama dan periode yang sama
    const checkResult = await pool.query(
      `SELECT id FROM attendances WHERE user_id = $1 AND attendance_date = $2 AND attendance_period_id = $3`,
      [user_id, date, attendance_period_id]
    );

    if (checkResult.rows.length > 0) {
      return res.status(400).json({ message: 'Attendance untuk hari ini sudah disubmit' });
    }

    // Insert attendance
    await pool.query(
      `INSERT INTO attendances (user_id, attendance_date, attendance_period_id) VALUES ($1, $2, $3)`,
      [user_id, date, attendance_period_id]
    );

    res.status(201).json({ message: 'Attendance berhasil disubmit' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Gagal submit attendance' });
  }
});

app.post('/overtime', async (req, res) => {
  const { user_id, date, hours } = req.body;

  try {
    if (hours < 1 || hours > 3) {
      return res.status(400).json({ message: 'Lembur maksimal 3 jam per hari' });
    }

    // Cek apakah user sudah submit lembur untuk tanggal yang sama
    const check = await pool.query(
      'SELECT * FROM overtimes WHERE user_id = $1 AND overtime_date = $2',
      [user_id, date]
    );

    if (check.rows.length > 0) {
      return res.status(400).json({ message: 'Sudah lembur hari ini' });
    }

    await pool.query(
      'INSERT INTO overtimes (user_id, overtime_date, hours) VALUES ($1, $2, $3)',
      [user_id, date, hours]
    );

    res.status(201).json({ message: 'Lembur berhasil disimpan' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Server error' });
  }
});

app.post('/reimbursement', async (req, res) => {
  const { user_id, date, amount, description } = req.body;

  try {
    if (amount <= 0) {
      return res.status(400).json({ message: 'Jumlah reimbursement harus lebih dari 0' });
    }

    await pool.query(
      'INSERT INTO reimbursements (user_id, date, amount, description) VALUES ($1, $2, $3, $4)',
      [user_id, date, amount, description]
    );

    res.status(201).json({ message: 'Reimbursement berhasil disimpan' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Server error' });
  }
});

app.post('/run-payroll', async (req, res) => {
  const { attendance_period_id, created_by } = req.body;

  const client = await pool.connect();
  try {
    await client.query('BEGIN');

    // 1. Cek periode valid
    const period = await client.query(
      'SELECT * FROM attendance_periods WHERE id = $1',
      [attendance_period_id]
    );
    if (period.rows.length === 0) {
      return res.status(404).json({ message: 'Attendance period tidak ditemukan' });
    }

    const { start_date, end_date } = period.rows[0];

    // 2. Cek apakah payroll sudah pernah dijalankan
    const existing = await client.query(
      'SELECT * FROM payrolls WHERE attendance_period_id = $1',
      [attendance_period_id]
    );
    if (existing.rows.length > 0) {
      return res.status(400).json({ message: 'Payroll untuk periode ini sudah dijalankan' });
    }

    // 3. Insert ke payrolls
    const result = await client.query(
      `INSERT INTO payrolls (attendance_period_id, run_at, created_by)
       VALUES ($1, NOW(), $2) RETURNING id`,
      [attendance_period_id, created_by]
    );
    const payrollId = result.rows[0].id;

    // 4. Ambil semua karyawan
    const users = await client.query("SELECT id, salary FROM users WHERE role = 'employee'");

    // 5. Proses masing-masing karyawan
    for (const user of users.rows) {
      const { id: userId, salary } = user;

      // Hitung kehadiran
      const attend = await client.query(
        'SELECT COUNT(*) FROM attendances WHERE user_id = $1 AND attendance_date BETWEEN $2 AND $3',
        [userId, start_date, end_date]
      );
      const attendance_days = parseInt(attend.rows[0].count);

      // Hitung lembur
      const ot = await client.query(
        'SELECT COALESCE(SUM(hours), 0) FROM overtimes WHERE user_id = $1 AND overtime_date BETWEEN $2 AND $3',
        [userId, start_date, end_date]
      );
      const overtime_hours = parseInt(ot.rows[0].coalesce);

      // Hitung reimbursement
      const reimb = await client.query(
        'SELECT COALESCE(SUM(amount), 0) FROM reimbursements WHERE user_id = $1 AND date BETWEEN $2 AND $3',
        [userId, start_date, end_date]
      );
      const reimbursement_total = parseFloat(reimb.rows[0].coalesce);

      // Kalkulasi gaji
      const daily = salary / 22;
      const hourly = daily / 8;
      const attendance_pay = attendance_days * daily;
      const overtime_pay = overtime_hours * hourly * 1.5;
      const take_home_pay = attendance_pay + overtime_pay + reimbursement_total;

      // Simpan ke payroll_details
      await client.query(
        `INSERT INTO payroll_details 
        (payroll_id, user_id, attendance_days_count, overtime_hours, reimbursement_total, take_home_pay)
        VALUES ($1, $2, $3, $4, $5, $6)`,
        [payrollId, userId, attendance_days, overtime_hours, reimbursement_total, take_home_pay]
      );
    }

    await client.query('COMMIT');
    res.status(201).json({ message: 'Payroll berhasil dijalankan' });
  } catch (err) {
    await client.query('ROLLBACK');
    console.error(err);
    res.status(500).json({ message: 'Gagal menjalankan payroll' });
  } finally {
    client.release();
  }
});

app.get('/payslips/:user_id/:attendance_period_id', async (req, res) => {
  const { user_id, attendance_period_id } = req.params;

  try {
    // 1. Ambil data user (misal dapat gaji dasar)
    const userResult = await pool.query('SELECT * FROM users WHERE id = $1', [user_id]);
    
    if (userResult.rows.length === 0) {
      return res.status(404).json({ message: 'User tidak ditemukan' });
    }
    const user = userResult.rows[0];
    const baseSalary = parseFloat(user.salary); // misal ada kolom salary

    // 2. Hitung attendance days
    const attendanceResult = await pool.query(
      `SELECT COUNT(DISTINCT attendance_date) AS attendance_days
       FROM attendances 
       WHERE user_id = $1 AND attendance_period_id = $2`,
      [user_id, attendance_period_id]
    );
    const attendance_days = parseInt(attendanceResult.rows[0].attendance_days);

    // 3. Hitung overtime hours (maks 3 jam per hari sudah di aturan saat submit)
    const overtimeResult = await pool.query(
      `SELECT COALESCE(SUM(hours), 0) AS overtime_hours
       FROM overtimes 
       WHERE user_id = $1 AND overtime_date BETWEEN
         (SELECT start_date FROM attendance_periods WHERE id = $2)
         AND
         (SELECT end_date FROM attendance_periods WHERE id = $2)`,
      [user_id, attendance_period_id]
    );
    const overtime_hours = parseFloat(overtimeResult.rows[0].overtime_hours);

    // 4. Ambil daftar reimbursement dan totalnya
    const reimbursementResult = await pool.query(
      `SELECT id, amount, description FROM reimbursements
       WHERE user_id = $1 AND date BETWEEN
         (SELECT start_date FROM attendance_periods WHERE id = $2)
         AND
         (SELECT end_date FROM attendance_periods WHERE id = $2)`,
      [user_id, attendance_period_id]
    );
    const reimbursements = reimbursementResult.rows;

    const reimbursement_total = reimbursements.reduce((sum, r) => sum + parseFloat(r.amount), 0);

    // 5. Hitung take-home pay
    // Misal:
    // gaji pokok dihitung proporsional kehadiran (hari kerja diasumsikan 22 hari kerja/bulan)
    // lembur dibayar 1.5x per jam dari hourly rate (salary / 22 / 8 jam kerja)
    // reimbursement dibayar penuh

    const total_working_days = 22; // bisa disesuaikan
    const daily_salary = baseSalary / total_working_days;
    const hourly_salary = daily_salary / 8;

    const attendance_pay = daily_salary * attendance_days;
    const overtime_pay = overtime_hours * hourly_salary * 1.5;
    const take_home_pay = attendance_pay + overtime_pay + reimbursement_total;

    // Response payslip
    res.json({
      user_id,
      attendance_period_id,
      base_salary: baseSalary,
      attendance: {
        days: attendance_days,
        amount: attendance_pay.toFixed(2),
      },
      overtime: {
        hours: overtime_hours,
        amount: overtime_pay.toFixed(2),
      },
      reimbursements,
      reimbursement_total: reimbursement_total.toFixed(2),
      take_home_pay: take_home_pay.toFixed(2),
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Gagal generate payslip' });
  }
});

app.post('/payroll/run/:attendance_period_id', async (req, res) => {
  const { attendance_period_id } = req.params;
  const admin_user_id = 8; // sementara hardcoded admin, nanti bisa pakai auth

  try {
    // 1. Cek apakah payroll sudah pernah dijalankan
    const check = await pool.query(
      'SELECT * FROM payrolls WHERE attendance_period_id = $1',
      [attendance_period_id]
    );
    if (check.rows.length > 0) {
      return res.status(400).json({ message: 'Payroll sudah dijalankan untuk periode ini' });
    }

    // 2. Ambil periode
    const periodRes = await pool.query(
      'SELECT * FROM attendance_periods WHERE id = $1',
      [attendance_period_id]
    );
    if (periodRes.rows.length === 0) {
      return res.status(404).json({ message: 'Attendance period tidak ditemukan' });
    }
    const period = periodRes.rows[0];

    // 3. Ambil semua user
    const usersRes = await pool.query('SELECT * FROM users WHERE role = $1', ['employee']);
    const users = usersRes.rows;

    // 4. Buat payroll record utama
    const payrollInsert = await pool.query(
      `INSERT INTO payrolls (attendance_period_id, created_by) VALUES ($1, $2) RETURNING id`,
      [attendance_period_id, admin_user_id]
    );
    const payroll_id = payrollInsert.rows[0].id;

    // 5. Untuk setiap user, hitung payslip dan simpan ke payroll_details
    for (const user of users) {
      const user_id = user.id;
      const baseSalary = parseFloat(user.salary) || 0;

      const attendanceRes = await pool.query(
        `SELECT COUNT(DISTINCT attendance_date) AS attendance_days FROM attendances
         WHERE user_id = $1 AND attendance_period_id = $2`,
        [user_id, attendance_period_id]
      );
      const attendance_days = parseInt(attendanceRes.rows[0].attendance_days) || 0;

      const overtimeRes = await pool.query(
        `SELECT COALESCE(SUM(hours), 0) AS overtime_hours FROM overtimes
         WHERE user_id = $1 AND overtime_date BETWEEN $2 AND $3`,
        [user_id, period.start_date, period.end_date]
      );
      const overtime_hours = parseFloat(overtimeRes.rows[0].overtime_hours) || 0;

      const reimbRes = await pool.query(
        `SELECT COALESCE(SUM(amount), 0) AS total FROM reimbursements
         WHERE user_id = $1 AND date BETWEEN $2 AND $3`,
        [user_id, period.start_date, period.end_date]
      );
      const reimbursement_total = parseFloat(reimbRes.rows[0].total) || 0;

      // Perhitungan gaji
      const total_days = 22;
      const daily = baseSalary / total_days;
      const hourly = daily / 8;
      const attendance_pay = daily * attendance_days;
      const overtime_pay = hourly * overtime_hours * 1.5;
      const take_home = attendance_pay + overtime_pay + reimbursement_total;

      // Simpan ke payroll_details
      await pool.query(
        `INSERT INTO payroll_details 
        (payroll_id, user_id, attendance_days_count, overtime_hours, reimbursement_total, take_home_pay)
        VALUES ($1, $2, $3, $4, $5, $6)`,
        [payroll_id, user_id, attendance_days, overtime_hours, reimbursement_total, take_home]
      );
    }

    res.status(200).json({ message: 'Payroll berhasil dijalankan', payroll_id });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Gagal menjalankan payroll' });
  }
});

app.get('/payroll-summary/:attendance_period_id', async (req, res) => {
  const { attendance_period_id } = req.params;

  try {
    // Pastikan payroll untuk attendance_period_id sudah ada
    const payrollRes = await pool.query(
      'SELECT id FROM payrolls WHERE attendance_period_id = $1',
      [attendance_period_id]
    );

    if (payrollRes.rows.length === 0) {
      return res.status(404).json({ message: 'Payroll untuk periode ini belum dijalankan' });
    }

    const payrollId = payrollRes.rows[0].id;

    // Ambil semua payroll_details untuk payroll ini
    const detailsRes = await pool.query(
      `SELECT users.id AS user_id, users.username, payroll_details.take_home_pay
       FROM payroll_details
       JOIN users ON users.id = payroll_details.user_id
       WHERE payroll_details.payroll_id = $1`,
      [payrollId]
    );

    const details = detailsRes.rows;

    // Total take home pay semua karyawan
    const totalTakeHomePay = details.reduce((sum, d) => sum + parseFloat(d.take_home_pay), 0);

    res.json({
      attendance_period_id,
      total_take_home_pay: totalTakeHomePay.toFixed(2),
      employee_pays: details.map(d => ({
        user_id: d.user_id,
        username: d.username,
        take_home_pay: parseFloat(d.take_home_pay).toFixed(2),
      })),
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Gagal mengambil summary payroll' });
  }
});