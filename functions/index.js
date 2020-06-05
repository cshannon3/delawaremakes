// var fs = require('fs')
// const path = require('path');
const functions = require('firebase-functions');
const admin = require('firebase-admin');

// const handlebars = require('handlebars');
// const cors = require('cors')({origin: true});
// const { v4: uuidv4 } = require('uuid');
// const secret = require('./secret');
// const nodemailer = require('nodemailer');
//https://www.youtube.com/watch?v=vThujL5-fZQ&t=305s

admin.initializeApp();
//const db = admin.firestore();



exports.sendNewOrgEmail = functions.firestore.document('orgs/{orgID}')
    .onCreate((event) => {
        const orgData = event.data()
        const sgMail = require('@sendgrid/mail');
        sgMail.setApiKey(process.env.SENDGRID_API_KEY);

        const msg = {
            to: orgData.contactEmail,
            from: 'connor.shannon@delawaremakes.org',
            templateId: 'd-5ff2a56ffcec4fe79a0e779289f54160',
            dynamic_template_data:{
                name: orgData.contactName,
                orgName: orgData.name,
                code: orgData.id.substring(0, 5)
            }
        };

        return sendGridEmail
        .send(msg)
        .then(() => console.log('email sent'))
        .catch((error) => console.error(error.toString()))
});
       
        
        
    // const msg = {
    //     to: emailTestData.emailAddress,
    //     from: 'noreply@juniortechbots.com',
    //     subject: 'My subject',
    //     templateId: '<enter your template id here>',
    //     dynamic_template_data: {
    //       clubname: emailTestData.clubname
    //     }
    //   }
// exports.sendOpenRequestEmail = functions.firestore.document('requests/{requestID}')
//     .onUpdate(async (change, context)=>{
//         //
//         const sgMail = require('@sendgrid/mail');
//         sgMail.setApiKey(process.env.SENDGRID_API_KEY);
//             const msg = {
//             to: dest,
//             from: 'connor.shannon@delawaremakes.org',
//             templateId: 'd-5ff2a56ffcec4fe79a0e779289f54160',
//             dynamic_template_data:{
    
//                 }
//             };
//             //ES8
//             (async () => {
//             try {
//                 await sgMail.send(msg);
//                  return {success:true};
//             } catch (error) {
//                 console.error(error);
    
//                 if (error.response) {
//                 console.error(error.response.body)
//                 }
//             }
//             })();
//     });

// exports.sendNewClaimEmail = functions.firestore.document('claims/{claimID}')
//     .onCreate(async (change, context)=>{
      
//         const sgMail = require('@sendgrid/mail');
//         sgMail.setApiKey(process.env.SENDGRID_API_KEY);
//             const msg = {
//             to: dest,
//             from: 'connor.shannon@delawaremakes.org',
//             templateId: 'd-d58a30e888a4450d9d9a76d7f8ceb2a0',
//             dynamic_template_data:{
    
//                 }
//             };
//             //ES8
//             (async () => {
//             try {
//                 await sgMail.send(msg);
//                  return {success:true};
//             } catch (error) {
//                 console.error(error);
    
//                 if (error.response) {
//                 console.error(error.response.body)
//                 }
//             }
//             })();
//     });

    // exports.sendEmail = functions.https.onRequest(async (req, res) => {
    
    //     const dest = req.query.dest;
    //     const orgName = req.query.orgName;
    //     const contactName = req.query.contactName;
    //     const code = req.query.code;
    
    //     const sgMail = require('@sendgrid/mail');
    //     sgMail.setApiKey(process.env.SENDGRID_API_KEY);
    //         const msg = {
    //         to: dest,
    //         from: 'connor.shannon@delawaremakes.org',
    //         templateId: '',
    //         dynamic_template_data:{
    
    //         }
    //         };
    //         //ES8
    //         (async () => {
    //         try {
    //             await sgMail.send(msg);
    //              return {success:true};
    //         } catch (error) {
    //             console.error(error);
    
    //             if (error.response) {
    //             console.error(error.response.body)
    //             }
    //         }
    //         })();
    // });
    


// var source = fs.readFileSync(path.join(__dirname, 'templates/request.hbs'), 'utf8');
// var template = handlebars.compile(source);

// exports.sendMailFB = functions.https.onRequest(async (req, res) => {
//      //cors(req, res, () => {
//          // getting dest email by query string
//         const id =uuidv4();
//         const dest = req.query.dest;
//         const orgName = req.query.orgName;
//         const contactName = req.query.contactName;
//         const code = req.query.code;
//         console.log(dest);
//         console.log(orgName);
//         const writeResult = await db.collection('mail').add({
//         //  from: 'Delaware Makes <delawaremakes@gmail.com>', // Something like: Jane Doe <janedoe@gmail.com>
//             to: dest,
//             message:{
//                 subject: 'New Request', // email subject
//                 html: template({
//                     "orgName":orgName,
//                     "contactName":contactName,
//                     "code":code
//                 })
//             }
//         });
//         console.log(writeResult.id);
//         return res.send({result: `Message with ID: ${writeResult.id} added.`});
//   // });
//  });
 

//  let transporter = nodemailer.createTransport({
//     service: 'gmail',
//     auth: {
//         user: 'delawaremakes@gmail.com',
//         pass: secret.emailPass()
//     }
// });
// exports.sendMail = functions.https.onRequest((req, res) => {
//     cors(req, res, () => {
//         // getting dest email by query string
//         const dest = req.query.dest;
//         const orgName = req.query.orgName;
//         const contactName = req.query.contactName;
//         console.log(dest);
//         console.log(orgName);
//         const mailOptions = {
//             from: 'Delaware Makes <delawaremakes@gmail.com>', // Something like: Jane Doe <janedoe@gmail.com>
//             to: dest,
//             subject: 'New Request', // email subject
//             html: template({
//                 "orgName":orgName,
//                 "contactName":contactName
//             })
//         };
//         // returning result
//         return transporter.sendMail(mailOptions, (erro, info) => {
//             if (erro) {
//                 res.send({error: erro.toString()});
//             } 
//             else {
//                 console.log("sent");
//                 res.status(200).send({data: 'Success: ' + req.body.message});
//             }
//         });
//     });    
// });



