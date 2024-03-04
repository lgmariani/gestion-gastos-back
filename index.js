const express = require("express");
const bodyParser = require("body-parser");
const { Sequelize, DataTypes } = require("sequelize");

//const sequelize = new Sequelize('sqlite::memory:'); // Base de datos en memoria

const sequelize = new Sequelize("sqlite::memory:", {
  host: "localhost",
  dialect: "sqlite",
  logging: console.log, // Habilita el logging de todas las consultas SQL
});

const cors = require("cors");

const fs = require("fs");

const app = express();
const PORT = 3005;

app.use(bodyParser.json());
app.use(cors());

// Definición del modelo Gasto
const Gasto = sequelize.define(
  "Gasto",
  {
    valor: {
      type: DataTypes.FLOAT,
      allowNull: false,
    },
    fecha: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    pagador: {
      type: DataTypes.NUMBER,
      allowNull: false,
    },
    comentario: {
      type: DataTypes.STRING,
    },
    categoria: {
      type: DataTypes.NUMBER,
      allowNull: false,
    },
  },
  {
    // Opciones adicionales
  }
);

// Sincroniza el modelo con la base de datos
sequelize.sync();

sequelize
  .sync()
  .then(() => {
    console.log("Base de datos sincronizada.");

    // Lee el archivo SQL y ejecuta las instrucciones
    const sql = fs.readFileSync("data.sql", "utf8");

    // Divide el archivo en instrucciones individuales
    const queries = sql
      .split(";")
      .map((query) => query.trim())
      .filter((query) => query.length);

    // Ejecuta cada instrucción SQL por separado
    for (let query of queries) {
      sequelize.query(query + ";").catch((error) => {
        console.error(
          "Error al ejecutar la consulta:",
          query,
          "\nError:",
          error
        );
      });
    }
  })
  .catch((error) => {
    console.error("Error al sincronizar la base de datos:", error);
  });
sequelize.sync();

// Rutas CRUD
app.get("/gastos", async (req, res) => {
  const gastos = await Gasto.findAll();
  res.json(gastos);
});



app.get("/gastos/:id", async (req, res) => {
  const { id } = req.params.id;
  const p = await Gasto.findByPk( id );
  console.log('req:');
  console.log(req);
  //     update(req.body, { where: { id } });
  res.json( p );
});


app.get('/get-total-by-person', async (req, res) => {
  try {
      const totalesPorPersona = await Gasto.findAll({
          attributes: [
              'pagador',
              [sequelize.fn('SUM', sequelize.col('valor')), 'totalGastado']
          ],
          group: ['pagador']
      });

      res.json(totalesPorPersona);
  } catch (error) {
      console.error('Error al obtener los totales:', error);
      res.status(500).send('Ocurrió un error al procesar tu solicitud');
  }
});


app.post("/gastos", async (req, res) => {
  console.log("hellou " + JSON.stringify(req.body));

  try {
    const gasto = await Gasto.create(req.body);
    res.status(201).json(gasto);
  } catch (error) {
    console.error(`Error al procesar la solicitud: ${error.message}`);
    console.error(error.stack);
    // Para Sequelize, puedes querer loguear también:
    console.error(error.errors); // Si están disponibles
    res.status(500).send("Ocurrió un error en el servidor");
  }
});

app.put("/gastos/:id", async (req, res) => {
  const { id } = req.params;
  const [updated] = await Gasto.update(req.body, { where: { id } });
  res.json({ message: `Updated ${updated} Gasto(s)` });
});

app.delete("/gastos/:id", async (req, res) => {
  const { id } = req.params;
  await Gasto.destroy({ where: { id } });
  res.json({ message: "Gasto deleted" });
});

app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
