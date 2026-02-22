import connection from "../config/db.js";

export const getAllTransportOptions = (req, res) => {
  const sqlFlight = "SELECT * FROM FLIGHT";
  const sqlTrain = "SELECT * FROM TRAIN";

  let data = {};

  connection.query(sqlFlight, (err, flights) => {
    if (err) return res.status(500).json({ error: "Flight query error" });

    data.flights = flights;

    connection.query(sqlTrain, (err, trains) => {
      if (err) return res.status(500).json({ error: "Train query error" });

      data.trains = trains;

      res.json(data);
    });
  });
};
