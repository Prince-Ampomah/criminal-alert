import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:criminal_alert/screen_widgets/notification_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {


  @override
  Widget build(BuildContext context) {
    Stream stream = Firestore.instance
        .collection('PoliceTips')
        .orderBy('time', descending: true)
        .snapshots();
    return Scaffold(
      body: StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          return snapshot.hasData? ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                snapshot.data.documents[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Card(
                      margin: EdgeInsets.symmetric(vertical: 5.0),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            topRight: Radius.circular(5.0),
                            bottomLeft: Radius.circular(5.0),
                            bottomRight: Radius.circular(5.0),
                          )),
                      child: InkWell(
                          onTap: (){
                            showDialog(context: context, builder: (context){
                              return NotificationDetailPage(snapshot: documentSnapshot);
                            });
                          },
                          splashColor: Colors.grey[300],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              topRight: Radius.circular(5.0),
                              bottomLeft: Radius.circular(5.0),
                              bottomRight: Radius.circular(5.0)),
                          child: Padding(
                            padding: EdgeInsets.all(7.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0, vertical: 5.0),
                                  child: Icon(
                                    Icons.notifications_active,
                                    color: Colors.red,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 7.0, vertical: 5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.90,
                                          child: Text(
                                            documentSnapshot.data['title'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                                color: Colors.grey[900],
                                                fontSize: 17.5,
                                                fontWeight:
                                                FontWeight.w700),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width,
                                          child: Text(
                                            documentSnapshot
                                                .data['content'],
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.justify,
                                            maxLines: 3,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Container(
                                            child: Text(
                                              documentSnapshot.data['time']
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize: 12),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                      )),
                );
              }) : Center(child: Text('No Data'));

 /*         switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              return snapshot.hasData
                  ? ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                    snapshot.data.documents[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Card(
                          margin: EdgeInsets.symmetric(vertical: 5.0),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                topRight: Radius.circular(5.0),
                                bottomLeft: Radius.circular(5.0),
                                bottomRight: Radius.circular(5.0),
                              )),
                          child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context)=> NotificationDetailPage(snapshot: documentSnapshot,)
                                ));
                              },
                              splashColor: Colors.grey[300],
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0),
                                  bottomLeft: Radius.circular(5.0),
                                  bottomRight: Radius.circular(5.0)),
                              child: Padding(
                                padding: EdgeInsets.all(7.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2.0, vertical: 5.0),
                                      child: Icon(
                                        Icons.notifications_active,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 7.0, vertical: 5.0),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.90,
                                              child: Text(
                                                documentSnapshot.data['title'],
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                    color: Colors.grey[900],
                                                    fontSize: 17.5,
                                                    fontWeight:
                                                    FontWeight.w700),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Text(
                                                documentSnapshot
                                                    .data['content'],
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.justify,
                                                maxLines: 3,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20.0,
                                            ),
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Container(
                                                child: Text(
                                                  documentSnapshot.data['time']
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.grey[700],
                                                      fontSize: 12),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                          )),
                    );
                  })
                  : Container(child: Center(child: Text('Loading....')));
          }*/
     /*     return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        snapshot.data.documents[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Card(
                          margin: EdgeInsets.symmetric(vertical: 5.0),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            topRight: Radius.circular(5.0),
                            bottomLeft: Radius.circular(5.0),
                            bottomRight: Radius.circular(5.0),
                          )),
                          child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=> NotificationDetailPage(snapshot: documentSnapshot,)
                                ));
                              },
                              splashColor: Colors.grey[300],
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0),
                                  bottomLeft: Radius.circular(5.0),
                                  bottomRight: Radius.circular(5.0)),
                              child: Padding(
                                padding: EdgeInsets.all(7.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2.0, vertical: 5.0),
                                      child: Icon(
                                        Icons.notifications_active,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 7.0, vertical: 5.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.90,
                                              child: Text(
                                                documentSnapshot.data['title'],
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                    color: Colors.grey[900],
                                                    fontSize: 17.5,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Text(
                                                documentSnapshot
                                                    .data['content'],
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.justify,
                                                maxLines: 3,
                                            ),
                                            ),
                                            SizedBox(
                                              height: 20.0,
                                            ),
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Container(
                                                child: Text(
                                                  documentSnapshot.data['time']
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.grey[700],
                                                      fontSize: 12),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                          )),
                    );
                  })
              : Container(
            child: Center(child: Text('Loading....')),
          );*/
        },
      ),
    );
  }
}
