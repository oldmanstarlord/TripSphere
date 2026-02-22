import connection from "../config/db.js";

export const loginUser = (req, res) => {
  const { username, password } = req.body;

  const sql = "SELECT * FROM users WHERE username = ? AND password = ?";

  connection.beginTransaction((err) => {
    if (err) return res.status(500).json({ message: "Transaction error" });

    connection.query(sql, [username, password], (err, results) => {
      if (err) {
        connection.rollback(() => {
          res.status(500).json({ message: "Database error" });
        });
        return;
      }

      if (results.length === 0) {
        connection.rollback(() => {
          res.status(401).json({ message: "Invalid username or password" });
        });
        return;
      }

      const user = results[0];

      // Example of DCL-like logic
      if (user.role === "admin") {
        console.log(`GRANT ALL PRIVILEGES TO '${user.username}'`);
      } else {
        console.log(`GRANT SELECT, INSERT ON travel_management.* TO '${user.username}'`);
      }

      connection.commit((err) => {
        if (err) {
          connection.rollback(() => res.status(500).json({ message: "Commit failed" }));
        } else {
          res.json({
            message: "Login successful",
            user: user,
          });
        }
      });
    });
  });
};
