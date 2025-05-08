import express from 'express';

const app = express();
const port = 3000;

// Middleware to parse JSON requests
app.use(express.json());

// /ping endpoint
app.get('/ping', (req, res) => {
    res.send({ message: 'pong' });
});

// /message endpoint
app.get('/message', (req, res) => {
  res.send({ message: 'This is a TypeScript Node.js app deployed from...' });
});

// Start the server
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
