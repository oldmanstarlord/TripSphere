import connection from "../config/db.js";

// ✅ Handles payment + booking together (Transaction-safe)
export const confirmBooking = (req, res) => {
  const { user_id, accommodation_id, transport_id, total_amount, payment_method } = req.body;

  // Start a MySQL transaction
  connection.beginTransaction((err) => {
    if (err) {
      console.error("❌ Transaction start failed:", err);
      return res.status(500).json({ error: "Transaction start failed" });
    }

    // Step 1️⃣: Insert into booking table
    const bookingSQL = `
      INSERT INTO booking (user_id, accommodation_id, transport_id, total_amount)
      VALUES (?, ?, ?, ?)
    `;
    connection.query(bookingSQL, [user_id, accommodation_id, transport_id, total_amount], (err, result) => {
      if (err) {
        console.error("❌ Booking insert failed:", err);
        return connection.rollback(() => res.status(500).json({ error: "Booking failed" }));
      }

      const booking_id = result.insertId;

      // Step 2️⃣: Insert payment record
      const transaction_id = "TXN" + Date.now();
      const paymentSQL = `
        INSERT INTO payment (booking_id, payment_method, amount, transaction_id)
        VALUES (?, ?, ?, ?)
      `;
      connection.query(paymentSQL, [booking_id, payment_method, total_amount, transaction_id], (err, paymentResult) => {
        if (err) {
          console.error("❌ Payment insert failed:", err);
          return connection.rollback(() => res.status(500).json({ error: "Payment failed" }));
        }

        // Step 3️⃣: Commit transaction
        connection.commit((err) => {
          if (err) {
            console.error("❌ Commit failed:", err);
            return connection.rollback(() => res.status(500).json({ error: "Commit failed" }));
          }

          console.log("✅ Booking and payment successful!");

          res.json({
            message: "✅ Booking and payment successful",
            booking_id,
            user_id,
            payment_id: paymentResult.insertId,
            transaction_id,
          });
        });
      });
    });
  });
};
