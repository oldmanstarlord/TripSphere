import connection from "../config/db.js";

export const getFlights = (req, res) => {
  const { from, to } = req.query;

  const sql = `
    SELECT * FROM FLIGHT 
    WHERE departure_airport = ? 
    AND arrival_airport = ?
  `;

  connection.query(sql, [from, to], (err, results) => {
    if (err) {
      console.error("Error fetching flights:", err);
      return res.status(500).json({ error: "Database error" });
    }
    res.json(results);
  });
};
