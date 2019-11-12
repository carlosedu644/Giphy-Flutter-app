import 'package:flutter/material.dart';
import 'package:gifs/ui/git_page.dart';
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class CreateGifTable extends StatelessWidget {
  final context;
  final snapshot;
  final String query;
  final VoidCallback click;

  CreateGifTable(
      {@required this.context,
      @required this.snapshot,
      this.query,
      this.click});
  @override
  Widget build(BuildContext context) {
    int _getCount(List data) {
      if (query == null || query.trim().length == 0) {
        return data == null ? 0 : data.length;
      } else {
        return data == null ? 0 : data.length + 1;
      }
    }

    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: _getCount(snapshot.data['data']),
      itemBuilder: (_, index) {
        if (query == null|| index < snapshot.data['data'].length) {
          return GestureDetector(
            child: FadeInImage.memoryNetwork(
              image: snapshot.data['data'][index]['images']['fixed_height']
                  ['url'],
              placeholder: kTransparentImage,
              height: 300.0,
              fit: BoxFit.cover,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GifPage(
                            gifData: snapshot.data['data'][index],
                          )));
            },
            onLongPress: () {
              Share.share(snapshot.data['data'][index]['images']['fixed_height']
                  ['url']);
            },
          );
        } else {
          return Container(
            child: GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.add,
                    size: 70,
                    color: Colors.white,
                  ),
                  Text(
                    'Carregar mais...',
                    style: TextStyle(color: Colors.white, fontSize: 22.0),
                  )
                ],
              ),
              onTap: click,
            ),
          );
        }
      },
    );
  }
}
