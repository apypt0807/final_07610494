import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:final_07610494/api.dart';
import 'package:final_07610494/footballitem.dart';
class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FootballItem>? _footballlist;
  var _isLoading = false;
  String? _errMessage;
  @override
  void initState() {
    super.initState();
    _fetchFootballData();
  }
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: AssetImage("assets/images/bg.png"),
            ),
          ),


          /*Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _fetchFoodData,
              child: const Text('GET FOOD DATA'),
            ),
          ),*/

          child: Stack(
            children: [
              if (_footballlist != null)
                ListView.builder(
                  itemBuilder: _buildListItem,
                  itemCount: _footballlist !.length,
                ),
              if (_isLoading)
                const Center(child: CircularProgressIndicator()),
              if (_errMessage != null && !_isLoading)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(_errMessage!),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _fetchFootballData();
                        },
                        child: const Text('RETRY'),
                      )
                    ],
                  ),
                ),
            ],
          ),



        ));
  }


  void _fetchFootballData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      var data = await Api().fetch('foods');
      setState(() {
        _footballlist = data
            .map<FootballItem>((item) => FootballItem.fromJson(item))
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Widget _buildListItem(BuildContext context, int index) {
    var foodItem = _footballlist![index];

    return Card(
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Image.network(
              foodItem.image,
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 8.0),
            Text(foodItem.team),
          ],
        ),
      ),
    );
  }
}