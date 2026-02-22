import connection from "../config/db.js";

export const getAllLocations = (req, res) => {
  connection.query("SELECT * FROM LOCATION", (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
};
