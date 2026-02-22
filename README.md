# TripSphere

> Travel management platform (voice-job-platform) — full-stack app with a Node/Express backend and React frontend.

## Overview

TripSphere provides booking and itinerary management for flights, trains, transport, accommodations and payments. The codebase is split into a backend API and a React frontend.

## Features

- User authentication and management
- Booking creation and retrieval
- Flight, train, transport and accommodation endpoints
- Itinerary and destination management
- Payment processing endpoints

## Tech stack

- Backend: Node.js, Express
- Frontend: React (Create React App)
- Database: MySQL (SQL schema included)

## Repository layout

- [backend](backend) — Express API, entry: [backend/server.js](backend/server.js)
- [frontend](frontend) — React app (src in `frontend/src`)
- [database/travel_management.sql](database/travel_management.sql) — DB schema and seed data

Key backend folders:
- [backend/controllers](backend/controllers) — route handlers
- [backend/routes](backend/routes) — Express routes
- [backend/models](backend/models) — data models

## Prerequisites

- Node.js (16+ recommended)
- npm or yarn
- MySQL server

## Quick start

1. Setup database

   - Create a MySQL database (e.g., `trip_sphere`) and import the schema:

```bash
mysql -u <user> -p < trip_sphere < database/travel_management.sql
```

2. Backend

```bash
cd backend
npm install
# create a .env file with DB and auth variables (example below)
# start the server (use the script available in package.json or run node server.js)
npm start    # or: node server.js
```

Example `.env` variables (adjust names if your code expects different keys):

```
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=yourpassword
DB_NAME=trip_sphere
DB_PORT=3306
PORT=5000
JWT_SECRET=your_jwt_secret
```

3. Frontend

```bash
cd frontend
npm install
npm start
```

Set the frontend API base URL if required (for example `REACT_APP_API_URL=http://localhost:5000/api`).

## API

The backend exposes REST endpoints located in [backend/routes](backend/routes). Example endpoints include:

- Authentication: `/api/login`
- Users: `/api/users`
- Bookings: `/api/bookings`
- Flights: `/api/flights`
- Trains: `/api/trains`
- Transport: `/api/transport`
- Accommodations: `/api/accommodations`
- Itineraries: `/api/itineraries`
- Payments: `/api/payments`
- Locations: `/api/locations`

Refer to the controllers in [backend/controllers](backend/controllers) for request/response details.

## Development notes

- The backend entry point is [backend/server.js](backend/server.js).
- The frontend is a typical CRA app in [frontend/src](frontend/src).
- Add environment variables to `.env` files as needed for local development.

## Testing & scripts

Check `backend/package.json` and `frontend/package.json` for available npm scripts (start, test, build, etc.).

## Contributing

1. Create a branch
2. Make changes and add tests where appropriate
3. Open a pull request describing your changes

## License

This repository does not include a license file. Add one if you plan to publish or share this project.
