import * as functions from 'firebase-functions';
import admin = require('firebase-admin');

// Only initialize here
admin.initializeApp({
    credential: admin.credential.applicationDefault(),
    databaseURL: 'https://simplefit-2020.firebaseio.com'
  });

const db = admin.firestore();

// Functions reference
// https://firebase.google.com/docs/functions/typescript

export const deleteUserProfile = functions.auth.user().onDelete(async (user) => {
    try {
        await db.collection('users').doc(user.uid).delete();
    } catch (error) {
        console.log(error);
    }
});
