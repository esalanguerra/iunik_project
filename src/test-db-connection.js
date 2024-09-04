require("dotenv").config();
const knex = require("knex")({
  client: "pg",
  connection: {
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
  },
});

async function testConnection() {
  try {
    // Testa a conexão com uma consulta simples
    const result = await knex.raw("SELECT 1+1 AS result");
    console.log(
      "Database connection successful:",
      result.rows[0].result === 2 ? "Connected" : "Not connected"
    );
  } catch (error) {
    console.error("Error connecting to the database:", error.message);
  } finally {
    // Fechar a conexão
    await knex.destroy();
  }
}

testConnection();
