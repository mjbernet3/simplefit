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

export const addWorkoutPreview = functions.firestore.document('users/{userId}/workouts/{workoutId}').onCreate(
    async (snapshot: any, context: any) => {
        const userId = context.params.userId;
        const workoutId = context.params.workoutId;
        const newWorkout = snapshot.data();

        const workoutPreview = {
            id: workoutId,
            name: newWorkout.name,
        };

        try {
            await db.collection('users').doc(userId).update({
                workouts: admin.firestore.FieldValue.arrayUnion(workoutPreview),
            });
        } catch (error) {
            console.log(error);
        }

        return null;
    }
);

// export const updateWorkoutPreview = functions.firestore.document('users/{userId}/workouts/{workoutId}').onUpdate(
//     async (change: any, context: any) => {
//         const userId = context.params.userId;
//         const workoutId = context.params.workoutId;
//         const newWorkout = change.after.data();
//         const oldWorkout = change.before.data();

//         if (newWorkout.name !== oldWorkout.name) {
//             const oldPreview = {
//                 id: workoutId,
//                 name: oldWorkout.name,
//             }

//             const newPreview = {
//                 id: workoutId,
//                 name: newWorkout.name,
//             }

//             try {
//                 await db.collection('users').doc(userId).get();

//                 //TODO: Modify the array values name and then replace the array
//             } catch (error) {
//                 console.log(error)
//             }
//         }

//         return null;
//     }
// );

export const deleteWorkoutPreview = functions.firestore.document('users/{userId}/workouts/{workoutId}').onDelete(
    async (snapshot: any, context: any) => {
        const userId = context.params.userId;
        const workoutId = context.params.workoutId;
        const deletedWorkout = snapshot.data();

        const workoutPreview = {
            id: workoutId,
            name: deletedWorkout.name,
        };

        try {
            await db.collection('users').doc(userId).update({
                workouts: admin.firestore.FieldValue.arrayRemove(workoutPreview),
            });
        } catch (error) {
            console.log(error);
        }

        return null;
    }
);
