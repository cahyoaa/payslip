const { Pool } = require('pg');
const { faker } = require('@faker-js/faker');

const pool = new Pool({
  user: 'payroll_user',
  host: 'localhost',
  database: 'payroll_db',
  password: '1',
  port: 5432,
});

async function seed() {
  await pool.query(`DELETE FROM users`); // optional bersihkan dulu

  // Admin
  await pool.query(
    `INSERT INTO users (username, password_hash, role, salary) VALUES ($1, $2, $3, $4)`,
    ['admin', 'admin123', 'admin', 0]
  );

  // 100 employees
  for (let i = 0; i < 100; i++) {
    const username = faker.internet.username().toLowerCase() + i;
    const password = 'password';
    const salary = faker.number.int({ min: 3000000, max: 10000000 });
    await pool.query(
      `INSERT INTO users (username, password_hash, role, salary) VALUES ($1, $2, $3, $4)`,
      [username, password, 'employee', salary]
    );
  }
  console.log('Seed selesai');
  process.exit(0);
}

seed().catch(console.error);