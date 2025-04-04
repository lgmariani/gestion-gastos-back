require('dotenv').config();
const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");
const { Pool } = require('pg');
const fs = require('fs');
// const dbConfig = require('./config/database');

// Ejemplo de uso con MySQL
// const connection = mysql.createConnection(dbConfig);

const sslConfig = process.env.DB_SSL === 'true'
  ? {
      ca: fs.readFileSync('./DigiCertGlobalRootCA.crt.pem'),
      rejectUnauthorized: process.env.NODE_ENV === 'production'
    }
  : false;

// Configuración de la conexión a la base de datos PostgreSQL
const pool = new Pool({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_DATABASE,
  ssl: sslConfig
});

// Mostrar variables de entorno
console.log('DB_HOST:', process.env.DB_HOST);
console.log('DB_PORT:', process.env.DB_PORT);
console.log('DB_USER:', process.env.DB_USER);
console.log('DB_PASSWORD:', process.env.DB_PASSWORD);
console.log('DB_DATABASE:', process.env.DB_DATABASE);
console.log('DB_SSL:', process.env.DB_SSL);
console.log('NODE_ENV:', process.env.NODE_ENV);
console.log('PORT:', process.env.APP_PORT);


const app = express();
const port = process.env.APP_PORT || 3005;

app.use(cors({ origin: '*' }));

app.use(bodyParser.json());

// Endpoint para obtener todos los gastos con paginación y ordenamiento
app.get("/gastos", async (req, res) => {
  try {
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 10;
    const offset = (page - 1) * limit;
    
    // Parámetros de ordenamiento
    const sort = req.query.sort || 'fecha';
    const order = (req.query.order || 'desc').toUpperCase();
    
    // Lista de campos permitidos para ordenar
    const allowedSortFields = ['id', 'valor', 'fecha', 'pagador', 'titulo', 'categoria', 'repartirentre', 'created_at', 'updated_at'];
    
    if (!allowedSortFields.includes(sort)) {
      return res.status(400).json({ error: "Campo de ordenamiento no válido" });
    }
    
    if (!['ASC', 'DESC'].includes(order)) {
      return res.status(400).json({ error: "Orden no válido. Use 'asc' o 'desc'" });
    }

    // Obtener el total de registros
    const countResult = await pool.query('SELECT COUNT(*) as total FROM gastos');
    const total = parseInt(countResult.rows[0].total);

    // Obtener los gastos paginados y ordenados
    const result = await pool.query(
      `SELECT * FROM gastos ORDER BY ${sort} ${order} LIMIT $1 OFFSET $2`,
      [limit, offset]
    );

    const totalPages = Math.ceil(total / limit);

    res.json({
      data: result.rows,
      pagination: {
        total,
        totalPages,
        currentPage: page,
        limit,
        hasNextPage: page < totalPages,
        hasPreviousPage: page > 1
      },
      sorting: {
        sort,
        order
      }
    });
  } catch (error) {
    console.error("Error al obtener los gastos:", error.message);
    res.status(500).json({ error: "Internal server error" });
  }
});

// Endpoint para obtener un gasto por ID
app.get("/gastos/:id", async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM gastos WHERE id = $1', [req.params.id]);
    if (result.rows.length > 0) {
      res.json(result.rows[0]);
    } else {
      res.status(404).json({ error: "Gasto not found" });
    }
  } catch (error) {
    console.error("Error al obtener el gasto:", error.message);
    res.status(500).json({ error: "Internal server error" });
  }
});

// Endpoint para agregar un nuevo gasto
app.post("/gastos", async (req, res) => {
  try {
    const { valor, fecha, pagador, titulo, categoria, repartirentre } = req.body;
    const now = new Date().toISOString();
    const result = await pool.query(
      'INSERT INTO gastos (valor, fecha, pagador, titulo, categoria, repartirentre, created_at, updated_at) VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING *',
      [valor, fecha, pagador, titulo, categoria, repartirentre, now, now]
    );
    res.status(201).json(result.rows[0]);
  } catch (error) {
    console.error("Error al crear el gasto:", error.message);
    res.status(500).json({ error: "Internal server error" });
  }
});

// Endpoint para actualizar un gasto
app.put("/gastos/:id", async (req, res) => {
  try {
    const { valor, fecha, pagador, titulo, categoria, repartirentre } = req.body;
    const result = await pool.query(
      'UPDATE gastos SET valor = $1, fecha = $2, pagador = $3, titulo = $4, categoria = $5, repartirentre = $6, updated_at = $7 WHERE id = $8 RETURNING *',
      [valor, fecha, pagador, titulo, categoria, repartirentre, new Date().toISOString(), req.params.id]
    );
    if (result.rows.length > 0) {
      res.json(result.rows[0]);
    } else {
      res.status(404).json({ error: "Gasto not found" });
    }
  } catch (error) {
    console.error("Error al actualizar el gasto:", error.message);
    res.status(500).json({ error: "Internal server error" });
  }
});

// Endpoint para eliminar un gasto
app.delete("/gastos/:id", async (req, res) => {
  try {
    const result = await pool.query('DELETE FROM gastos WHERE id = $1 RETURNING *', [req.params.id]);
    if (result.rows.length > 0) {
      res.json({ message: "Gasto deleted" });
    } else {
      res.status(404).json({ error: "Gasto not found" });
    }
  } catch (error) {
    console.error("Error al eliminar el gasto:", error.message);
    res.status(500).json({ error: "Internal server error" });
  }
});

// Endpoint para obtener totales por persona
app.get('/get-total-by-person-new', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM total_by_person');
    res.json(result.rows);
  } catch (error) {
    console.error('Error al obtener los totales:', error.message);
    res.status(500).json({ error: "Internal server error" });
  }
});

// Endpoint para obtener totales por persona (agrupado)
app.get('/get-total-by-person', async (req, res) => {
  try {
    const result = await pool.query('SELECT pagador, sum(total) as total_gastado FROM total_by_person GROUP BY pagador');
    res.json(result.rows);
  } catch (error) {
    console.error('Error al obtener los totales:', error.message);
    res.status(500).json({ error: "Internal server error" });
  }
});

app.listen(port, () => {
  console.log(`Servidor corriendo en el puerto ${port}`);
});
