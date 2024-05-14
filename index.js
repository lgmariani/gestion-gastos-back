const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");
const mysql = require('mysql2/promise');

// Configuración de la conexión a la base de datos MySQL
const pool = mysql.createPool({
  host: 'localhost',
  user: 'ggadmin',
  password: 'pqpq2020',
  database: 'gestion-gastos',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

const app = express();
const PORT = 3005;

app.use(cors({ origin: '*' }));

app.use(bodyParser.json());

// Endpoint para obtener todos los gastos
app.get("/gastos", async (req, res) => {
  try {
    const [rows, fields] = await pool.query('SELECT * FROM Gastos');
    res.json(rows);
  } catch (error) {
    console.error("Error al obtener los gastos:", error.message);
    res.status(500).json({ error: "Internal server error" });
  }
});

// Endpoint para obtener un gasto por ID
app.get("/gastos/:id", async (req, res) => {
  try {
    const [rows, fields] = await pool.query('SELECT * FROM Gastos WHERE id = ?', [req.params.id]);
    if (rows.length > 0) {
      res.json(rows[0]);
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
    const result = await pool.query('INSERT INTO Gastos (valor, fecha, pagador, titulo, categoria, repartirentre) VALUES (?, ?, ?, ?, ?, ?)', [valor, fecha, pagador, titulo, categoria, repartirentre]);
    res.status(201).json({ id: result[0].insertId, ...req.body });
  } catch (error) {
    console.error("Error al crear el gasto:", error.message);
    res.status(500).json({ error: "Internal server error" });
  }
});

// Endpoint para actualizar un gasto
app.put("/gastos/:id", async (req, res) => {
  try {
    const { valor, fecha, pagador, titulo, categoria, repartirentre } = req.body;
    const result = await pool.query('UPDATE Gastos SET valor = ?, fecha = ?, pagador = ?, titulo = ?, categoria = ?, repartirentre = ? WHERE id = ?', [valor, fecha, pagador, titulo, categoria, repartirentre, req.params.id]);
    if (result[0].affectedRows > 0) {
      res.json({ id: req.params.id, ...req.body });
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
    const result = await pool.query('DELETE FROM Gastos WHERE id = ?', [req.params.id]);
    if (result[0].affectedRows > 0) {
      res.json({ message: "Gasto deleted" });
    } else {
      res.status(404).json({ error: "Gasto not found" });
    }
  } catch (error) {
    console.error("Error al eliminar el gasto:", error.message);
    res.status(500).json({ error: "Internal server error" });
  }
});

// Solucionar el problema con la vista 'total-by-person'
app.get('/get-total-by-person-new', async (req, res) => {
  try {
      const [rows, fields] = await pool.query('SELECT * FROM total_by_person');
      res.json(rows);
  } catch (error) {
      console.error('Error al obtener los totales:', error.message);
      res.status(500).json({ error: "Internal server error" });
  }
});

// Solucionar el problema con la vista 'total-by-person'
app.get('/get-total-by-person', async (req, res) => {
  try {
      const [rows, fields] = await pool.query('SELECT pagador, sum(total) as totalGastado FROM total_by_person GROUP BY pagador');
      res.json(rows);
  } catch (error) {
      console.error('Error al obtener los totales:', error.message);
      res.status(500).json({ error: "Internal server error" });
  }
});

app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
