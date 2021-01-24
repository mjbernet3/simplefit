const functions = require('firebase-functions');
const admin = require('firebase-admin');

// Only initialize here
admin.initializeApp({
    credential: admin.credential.applicationDefault(),
    databaseURL: 'https://simplefit-2020.firebaseio.com'
  });

const db = admin.firestore();

// Functions reference
// https://firebase.google.com/docs/functions/typescript

export const deleteUserProfile = functions.auth.user().onDelete(
    async (user: any) => {
        try {
            await db.collection('users').doc(user.uid).delete();
        } catch (error) {
            console.log(error);
        }

        return null;
    }
);

export const claimUsername = functions.firestore.document('users/{userId}').onCreate(
    async (snapshot: any, context: any) => {
        const newProfile = snapshot.data();
        const username = newProfile.username;

        try {
            await db.collection('usernames').doc(username).set({});
        } catch (error) {
            console.log(error);
        }

        return null;
    }
);

export const releaseUsername = functions.firestore.document('users/{userId}').onDelete(
    async (snapshot: any, context: any) => {
        const deletedProfile = snapshot.data();
        const username = deletedProfile.username;

        try {
            await db.collection('usernames').doc(username).delete();
        } catch (error) {
            console.log(error);
        }

        return null;
    }
);
