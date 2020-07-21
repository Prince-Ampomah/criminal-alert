const functions = require('firebase-functions');

const admin = require('firebase-admin');

admin.initializeApp(functions.config().firebase);

exports.policeTips = functions.firestore.document('PoliceTips/{PoliceTipsId}')
    .onCreate(async (snapshot) => {
        if (snapshot.empty) {
            console.log('No Police Tips');
            return;
        }

        var tokens = [];
       
        const victimTokens = await admin.firestore().collection('VictimDeviceToken').get();

        for (var token of victimTokens.docs) {
            tokens.push(token.data().victimDeviceToken);
        }


    // const text = snapshot.data().text;
    // const payload = {
    //   notification: {
    //     title: `${snapshot.data().name} posted ${text ? 'a message' : 'an image'}`,
        // body: text ? (text.length <= 100 ? text : text.substring(0, 97) + '...') : '',
    //     icon: snapshot.data().profilePicUrl || '/images/profile_placeholder.png',
    //     click_action: `https://${process.env.GCLOUD_PROJECT}.firebaseapp.com`,
    //   }
    // };

        const title = `${snapshot.data().title}`;
        const content = `${snapshot.data().content}`;

        var payload = {
            notification: {
                title: title,
                body: content ? (content.length <= 100 ? content : content.substring(0, 97) + '...' ) : '',
                sound: "default"
            },
            data: {
                click_action: 'FLUTTER_NOTIFICATION_CLICK',
                message: content
            }
        };

        try {
            await admin.messaging().sendToDevice(tokens, payload);
            console.log('Push Notification Sent');            
        } catch (error) {
            console.log("Error here: " + error);
        }



    });


