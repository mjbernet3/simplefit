const auth = require("firebase-functions/v1/auth");
const firestore = require("firebase-functions/v1/firestore");
const admin = require("firebase-admin");

// Only initialize here
admin.initializeApp({
  credential: admin.credential.applicationDefault(),
  databaseURL: "https://simplefit-2020.firebaseio.com",
});

const db = admin.firestore();

exports.deleteUserProfile = auth.user().onDelete(async (user) => {
  try {
    await db.collection("users").doc(user.uid).delete();
    console.log("Deleted profile for user: " + JSON.stringify(user));
  } catch (error) {
    console.error(
      "Failed to delete profile for user: " + JSON.stringify(user),
      error,
    );
  }

  return null;
});

exports.claimUsername = firestore
  .document("users/{userId}")
  .onCreate(async (snapshot, context) => {
    const newProfile = snapshot.data();
    const username = newProfile.username;

    try {
      await db.collection("usernames").doc(username).set({});
      console.log("Claimed username: " + username);
    } catch (error) {
      console.error("Failed to claim username: " + username, error);
    }

    return null;
  });

exports.releaseUsername = firestore
  .document("users/{userId}")
  .onDelete(async (snapshot, context) => {
    const deletedProfile = snapshot.data();
    const username = deletedProfile.username;

    try {
      await db.collection("usernames").doc(username).delete();
      console.log("Released username: " + username);
    } catch (error) {
      console.error("Failed to release username: " + username, error);
    }

    return null;
  });
