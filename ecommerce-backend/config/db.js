const { Sequelize } = require('sequelize');

const sequelize = new Sequelize('ecommerce_db"', 'ecom_user', 'YourNewPassword123', {
    host: 'localhost',
    dialect: 'mysql', // or 'postgres'
});

module.exports = sequelize;
