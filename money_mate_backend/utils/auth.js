const jwt = require('jsonwebtoken');
const config = require('./config')
const User = require("../models/userModel");

function GenerateToken(id) {
    console.log(config.tokenKey)
    const payload = {
      id: id,
    };
    const token = jwt.sign(payload, config.tokenKey);
    return token;
};

function validateToken(req, res, next) {
    var token = req.headers.authorization
    if (!token) {
        return res.status(401).json({ message: 'Not Authorized' });
    }
    token = token.split(' ')[1];
    jwt.verify(token, config.tokenKey, (err, decoded) => {
        if (err) {
            return res.status(403).json({ message: 'Failed to authenticate token' });
        }
        req.user_id = decoded.id;
        req._user = User.findById(decoded.id);
        next();
    });
};

module.exports = {
    GenerateToken,
    validateToken
}