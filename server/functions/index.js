const functions = require("firebase-functions");
const admin = require("firebase-admin");

// Only initialize here
admin.initializeApp({
  credential: admin.credential.applicationDefault(),
  databaseURL: "https://simplefit-2020.firebaseio.com",
});

const db = admin.firestore();

exports.deleteUserProfile = functions.auth.user().onDelete(async (user) => {
  try {
    await db.collection("users").doc(user.uid).delete();
  } catch (error) {
    console.log(error);
  }

  return null;
});

exports.claimUsername = functions.firestore
  .document("users/{userId}")
  .onCreate(async (snapshot, context) => {
    const newProfile = snapshot.data();
    const username = newProfile.username;

    try {
      await db.collection("usernames").doc(username).set({});
    } catch (error) {
      console.log(error);
    }

    return null;
  });

exports.releaseUsername = functions.firestore
  .document("users/{userId}")
  .onDelete(async (snapshot, context) => {
    const deletedProfile = snapshot.data();
    const username = deletedProfile.username;

    try {
      await db.collection("usernames").doc(username).delete();
    } catch (error) {
      console.log(error);
    }

    return null;
  });
