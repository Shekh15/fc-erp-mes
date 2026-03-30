// const { Pool } = require("pg");

const mysql = require('mysql2/promise');
require('dotenv').config();

// console.log("DB USER FROM ENV:", process.env.DB_USER); 
// console.log("DB NAME FROM ENV:", process.env.DB_NAME);

// const pool = new Pool({
//   host: process.env.DB_HOST,
//   port: Number(process.env.DB_PORT),
//   database: process.env.DB_NAME,
//   user: process.env.DB_USER,          
//   password: String(process.env.DB_PASSWORD),
//   ssl: false,
// });

const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_NAME,
  waitForConnections: true,
  ssl:false,
  connectionLimit: 10
});

pool.on("connect", () => {
  console.log("✅ Connected to PostgreSQL as", process.env.DB_USER);
});

pool.on("error", (err) => {
  console.error("❌ PostgreSQL error:", err.message);
  process.exit(1);
});

module.exports = pool;







