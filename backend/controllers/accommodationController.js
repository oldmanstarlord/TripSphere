import connection from "../config/db.js";

export const getAccommodations = (req, res) => {
  const { location } = req.query;

  const sql = location
    ? "SELECT * FROM ACCOMMODATION WHERE location = ?"
    : "SELECT * FROM ACCOMMODATION";

  const params = location ? [location] : [];

  connection.query(sql, params, (err, results) => {
    if (err) {
      console.error("❌ Error fetching accommodations:", err);
      return res.status(500).json({ error: "Database error" });
    }

    res.json(results);
  });
};
