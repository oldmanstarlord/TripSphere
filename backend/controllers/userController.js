import connection from "../config/db.js";

export const loginUser = (req, res) => {
  const { username, password } = req.body;

  // Find the user
  const sql = "SELECT * FROM users WHERE username = ?";
  connection.query(sql, [username], (err, results) => {
    if (err) {
      console.error("DB Error:", err);
      return res.status(500).json({ message: "Database error" });
    }

    if (results.length === 0) {
      return res.status(400).json({ message: "User not found" });
    }

    const user = results[0];

    // Plain text password comparison (simple for DBMS project)
    if (user.password !== password) {
      return res.status(401).json({ message: "Incorrect password" });
    }

    res.json({
      message: "Login successful",
      user: {
        user_id: user.user_id,
        username: user.username,
        role: user.role
      }
    });
  });
};
