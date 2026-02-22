// backend/models/userModel.js
const db = require('../config/db');

// Get all users
function getAllUsers(callback) {
  db.query('SELECT * FROM user', callback);
}

// Get user by ID
function getUserById(id, callback) {
  db.query('SELECT * FROM user WHERE user_id = ?', [id], (err, results) => {
    if (err) return callback(err);
    callback(null, results[0]);
  });
}

// Create a new user
function createUser(user, callback) {
  const { name, username, email, phone_no, address } = user;
  const sql = `
    INSERT INTO user (name, username, email, phone_no, address)
    VALUES (?, ?, ?, ?, ?)
  `;
  db.query(sql, [name, username, email, phone_no, address], callback);
}

module.exports = {
  getAllUsers,
  getUserById,
  createUser
};
