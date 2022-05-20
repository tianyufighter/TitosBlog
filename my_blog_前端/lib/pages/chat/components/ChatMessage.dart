import 'package:flutter/material.dart';
import 'package:my_blog/model/Chat.dart';

import 'ImageZoomable.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage(
      {
        this.chat,
        this.myName,
        this.friendPortrait,
        this.myPortrait});
  Chat? chat;
  String? myName;
  String? friendPortrait;
  String? myPortrait;

  @override
  Widget build(BuildContext context) {
    Widget _sheSessionStyle() {
      return new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: new CircleAvatar(
                // backgroundImage: new NetworkImage(friendPortrait!)),
                  backgroundImage: new AssetImage("assets/ic_default_avatar.png")),
            ),
            new Flexible(
                child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(chat!.sendUsername!,
                          style: Theme.of(context).textTheme.subhead),
                      new Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        child: chat!.imageUrl != null
                            ? new GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                                new MaterialPageRoute<Null>(
                                    builder: (BuildContext context) {
                                      return new ImageZoomable(
                                        // new NetworkImage(chat!.imageUrl!),
                                        AssetImage("assets/ic_default_avatar.png"),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                      );
                                    }));
                          },
                          child: new Image.network(
                            chat!.imageUrl!,
                            width: 150.0,
                          ),
                        )
                            : new Text(chat!.message!),
                      )
                    ])),
          ]);
    }

    Widget _mySessionStyle() {
      return new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Flexible(
                child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      new Text(chat!.sendUsername!,
                          style: Theme.of(context).textTheme.subhead),
                      new Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        child: chat!.imageUrl != null
                            ? new GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                                new MaterialPageRoute<Null>(
                                    builder: (BuildContext context) {
                                      return new ImageZoomable(
                                        // new NetworkImage(chat!.imageUrl!),
                                        new AssetImage("assets/ic_default_avatar.png"),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                      );
                                    }));
                          },
                          child: new Image.network(
                            chat!.imageUrl!,
                            width: 150.0,
                          ),
                        )
                            : new Text(chat!.message!),
                      )
                    ])),
            new Container(
              margin: const EdgeInsets.only(left: 16.0),
              child: new CircleAvatar(
                // backgroundImage: new NetworkImage(myPortrait!)),
                  backgroundImage: new AssetImage("assets/ic_default_avatar.png")),
            ),
          ]);
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: myName == chat!.sendUsername
          ? _mySessionStyle()
          : _sheSessionStyle(),
    );
  }
}