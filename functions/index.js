var fs = require('fs')
const path = require('path');
const functions = require('firebase-functions');
const admin = require('firebase-admin');

const handlebars = require('handlebars');

admin.initializeApp();
const db = admin.firestore();

var source = fs.readFileSync(path.join(__dirname, 'templates/request.hbs'), 'utf8');
var template = handlebars.compile(source);



exports.sendMailFB = functions.https.onRequest(async (req, res) => {
    // cors(req, res, () => {
         // getting dest email by query string
        const id =uuidv4();
        const dest = req.query.dest;
        const orgName = req.query.orgName;
        const contactName = req.query.contactName;
        const code = req.query.code;
        console.log(dest);
        console.log(orgName);
        const writeResult = await db.collection('mail').add({
        //  from: 'Delaware Makes <delawaremakes@gmail.com>', // Something like: Jane Doe <janedoe@gmail.com>
            to: dest,
            message:{
                subject: 'New Request', // email subject
                html: template({
                    "orgName":orgName,
                    "contactName":contactName,
                    "code":code
                })
            }
        });
        console.log(writeResult.id);
        return res.send({result: `Message with ID: ${writeResult.id} added.`});
       
 });
 


const cors = require('cors')({origin: true});
const { v4: uuidv4 } = require('uuid');
const secret = require('./secret');
const nodemailer = require('nodemailer');

 let transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: 'delawaremakes@gmail.com',
        pass: secret.emailPass()
    }
});
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



