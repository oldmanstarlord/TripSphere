import connection from "../config/db.js";

// Create Booking
export const createBooking = (req, res) => {
  const {
    user_id,
    accommodation_id,
    transport_type,
    transport_id,
    itinerary_id,
    payment_id,
    total_amount
  } = req.body;

  const sql = `
    INSERT INTO booking 
    (user_id, accommodation_id, transport_type, transport_id, itinerary_id, payment_id, total_amount)
    VALUES (?, ?, ?, ?, ?, ?, ?)
  `;

  connection.query(
    sql,
    [user_id, accommodation_id, transport_type, transport_id, itinerary_id, payment_id, total_amount],
    (err, result) => {
      if (err) {
        console.error("❌ Error creating booking:", err);
        return res.status(500).json({ message: "Database error" });
      }
      res.json({ message: "✅ Booking created successfully", booking_id: result.insertId });
    }
  );
};

// Get All Bookings
export const getAllBookings = (req, res) => {
  connection.query("SELECT * FROM booking", (err, results) => {
    if (err) {
      console.error("❌ Error fetching bookings:", err);
      return res.status(500).json({ message: "Database error" });
    }
    res.json(results);
  });
};
