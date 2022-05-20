import 'package:flutter/material.dart';

import '../ChatPage.dart';

class GroupChatListBodyItem extends StatelessWidget {
  final String? friendName;
  final String? lastMessage;
  final String? timestamp;
  final String? myName;
  final String? friendPortrait;
  final String? myPortrait;

  GroupChatListBodyItem({
    this.friendName,
    this.lastMessage,
    this.timestamp,
    this.myName,
    this.friendPortrait,
    this.myPortrait,
  });

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute<Null>(
            builder: (BuildContext context) {
              return new ChatPage(
                myName: myName,
                friendName: friendName,
                friendPortrait: friendPortrait,
                myPortrait: myPortrait,
              );
            },
          ));
        },
        child: new Container(
            decoration: new BoxDecoration(),
            padding: new EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: new Row(
              children: <Widget>[
                new CircleAvatar(
                    // backgroundImage: new NetworkImage(friendPortrait!)),
                      backgroundImage: AssetImage("assets/ic_default_avatar.png")),
                new Flexible(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Text("  " + friendName!, textScaleFactor: 1.2),
                              new Text(timestamp!.substring(0, 10),
                                  textAlign: TextAlign.right,
                                  style: new TextStyle(
                                      color: Theme.of(context).hintColor)),
                            ]),
                        new Container(
                            padding: new EdgeInsets.only(top: 2.0),
                            child: new Text("  " + lastMessage!,
                                overflow: TextOverflow.ellipsis,
                                style: new TextStyle(
                                    color: Theme.of(context).hintColor))),
                      ],
                    ))
              ],
            )));
  }
}