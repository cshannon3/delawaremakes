
const functions = require('firebase-functions');
const admin = require('firebase-admin');
const secret = require('./secret');
const nodemailer = require('nodemailer');
const handlebars = require('handlebars');
var fs = require('fs')
const path = require('path');

const cors = require('cors')({origin: true});
admin.initializeApp();

/**
* Here we're using Gmail to send 
*/
//const db = admin.firestore();
let transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: 'delawaremakes@gmail.com',
        pass: secret.emailPass()
    }
});

var source = fs.readFileSync(path.join(__dirname, 'templates/request.hbs'), 'utf8');
var template = handlebars.compile(source);


exports.sendMail = functions.https.onRequest((req, res) => {
    cors(req, res, () => {
        // getting dest email by query string
        const dest = req.query.dest;
        const orgName = req.query.orgName;
        const contactName = req.query.contactName;
        console.log(dest);
        console.log(orgName);
        const mailOptions = {
            from: 'Delaware Makes <delawaremakes@gmail.com>', // Something like: Jane Doe <janedoe@gmail.com>
            to: dest,
            subject: 'New Request', // email subject
            html: template({
                "orgName":orgName,
                "contactName":contactName
            })
        };
        // returning result
        return transporter.sendMail(mailOptions, (erro, info) => {
            if (erro) {
                res.send({error: erro.toString()});
            } 
            else {
                console.log("sent");
                res.status(200).send({data: 'Success: ' + req.body.message});
            }
        });
    });    
});
