DeviceAll-iOS [Under Developement]
==============

It is a testing project for iOS App Testing on multiple platform. Mostly we are facing the same problem that testing an app of same process for each device variants (models and os versions). That is so irritating for us.

So why not make a node socket connection, which work to make all socket connections and broadcast one device to all, thats why I named it DeviceAll-iOS project. Each iOS device at `DEBUG` mode connect to that node server, and sending each device window device touch point to server. When other device receive the points of touch it actual touch that points. Simple concept for initial.


Run node.js server as `$ node server.js` and it will run on your `SYSTEM-IP:5000`.
