# Firebase Function: sendEmail

This directory is a placeholder for a Firebase Cloud Function used to send emails from the portfolio contact form.

Recommended stack:
- Node.js 18 Functions
- SendGrid (or any SMTP provider)

## Steps
1. Install Firebase Tools and init functions:
   - npm i -g firebase-tools
   - firebase login
   - firebase init functions (select JavaScript or TypeScript)

2. Install dependencies in functions/:
   - npm i @sendgrid/mail cors

3. Create `index.js` (or `src/index.ts`) with an HTTPS function:
```
const functions = require('firebase-functions');
const cors = require('cors')({ origin: true });
const sgMail = require('@sendgrid/mail');
sgMail.setApiKey(process.env.SENDGRID_API_KEY);

exports.sendEmail = functions.https.onRequest((req, res) => {
  cors(req, res, async () => {
    if (req.method !== 'POST') return res.status(405).send('Method Not Allowed');
    const { name, email, message } = req.body || {};
    if (!name || !email || !message) return res.status(400).send('Missing fields');

    const msg = {
      to: 'mianadee25@gmail.com',
      from: 'noreply@yourdomain.com',
      subject: `Portfolio Contact from ${name}`,
      text: `From: ${name} <${email}>\n\n${message}`,
    };

    try {
      await sgMail.send(msg);
      return res.status(200).send('OK');
    } catch (e) {
      console.error(e);
      return res.status(500).send('Failed');
    }
  });
});
```

4. Deploy:
- firebase deploy --only functions

5. Use the deployed URL in Flutter:
- flutter run -d chrome --dart-define=EMAIL_API_URL=https://<region>-<project>.cloudfunctions.net/sendEmail

Note: configure `SENDGRID_API_KEY` in Functions env: `firebase functions:config:set sendgrid.key=YOUR_KEY` and read it in code.


