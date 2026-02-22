import connection from "../config/db.js";

export const getTrains = (req, res) => {
  const { to } = req.query;

  const sql = `
    SELECT * FROM TRAIN
    WHERE arrival_destination = ?
  `;

  connection.query(sql, [to], (err, results) => {
    if (err) {
      console.error("Error fetching trains:", err);
      return res.status(500).json({ error: "Database error" });
    }
    res.json(results);
  });
};
