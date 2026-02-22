import connection from "../config/db.js";

export const getItineraryByDestination = (req, res) => {
  const { destination } = req.params;

  const sql = `
    SELECT activity 
    FROM ITINERARY 
    WHERE destination = ?
  `;

  connection.query(sql, [destination], (err, results) => {
    if (err) {
      console.error("❌ Error fetching itinerary:", err);
      return res.status(500).json({ error: "Database error" });
    }

    res.json(results);
  });
};
