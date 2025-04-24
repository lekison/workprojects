const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const sequelize = require('./config/db');
const productRoutes = require('./routes/productRoutes');

const app = express();
app.use(cors());
app.use(bodyParser.json());

// Product API Route
app.use('/api/products', productRoutes);

sequelize.sync().then(() => {
    app.listen(5000, () => console.log('Server running on port 5000'));
}).catch(err => console.log(err));
