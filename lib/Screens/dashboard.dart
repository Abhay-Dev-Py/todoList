import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class TodoModel {
  String date;
  String eventDescription;
  TodoModel({required this.date, required this.eventDescription});
}

class _DashBoardState extends State<DashBoard> {
  List<TodoModel> listOfTaskGlobal = [];
  List<TodoModel> listOfTaskDisplay = [];
  TextEditingController dateController = new TextEditingController();

  TextEditingController descController = new TextEditingController();
  String date = '';
  String desc = '';

  void initState() {
    super.initState();
    setState(() {
      listOfTaskDisplay = listOfTaskGlobal;
    });
  }

  addToList(TodoModel obj) {
    setState(() {
      listOfTaskGlobal.add(obj);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Todo App"),
        ),
        // body: Container(
        //   height: MediaQuery.of(context).size.height * 1,
        //   width: MediaQuery.of(context).size.width * 1,
        //   color: Colors.red,
        // ),

        body: SingleChildScrollView(
          child: ListView(
            children: [
              //Search widget
              Row(
                children: [
                  TextFormField(
                    onChanged: (keyword) {
                      //search keyword in listOfTask
                      List<TodoModel> filteredTodo = [];
                      List<int> indexOfMatchedTodo = [];
                      // for (int i = 0; i < listOfTaskGlobal.length; i++) {
                      //   List<String> splitEventDesc =
                      //       listOfTaskGlobal[i].eventDescription.split(' ');
                      //   //iterate in spiltEventDesc
                      //   for (int j = 0; j < splitEventDesc.length; j++) {
                      //     if (keyword == splitEventDesc[j]) {
                      //       indexOfMatchedTodo.add(i);
                      //     }
                      //   }
                      // }
                      // print(
                      //     'Matched Index -> ' + indexOfMatchedTodo.toString());
                      // int k = 0;
                      // for (k = 0; k < indexOfMatchedTodo.length; k++) {
                      //   filteredTodo
                      //       .add(listOfTaskGlobal[indexOfMatchedTodo[k]]);
                      // }
                      // listOfTaskDisplay = filteredTodo;
                      // String a = 'My name is Abhay';
                      // String b = 'My';
                      // a.allMatches(b);
                      // a.contains('d');
                      //New code
                      for (int i = 0; i < listOfTaskGlobal.length; i++) {
                        if (listOfTaskGlobal[i]
                            .eventDescription
                            .contains(keyword)) {
                          indexOfMatchedTodo.add(i);
                        }
                      }
                      print(
                          'Matched Index -> ' + indexOfMatchedTodo.toString());
                      int k = 0;
                      for (k = 0; k < indexOfMatchedTodo.length; k++) {
                        filteredTodo
                            .add(listOfTaskGlobal[indexOfMatchedTodo[k]]);
                      }
                      listOfTaskDisplay = filteredTodo;
                    },
                    decoration: InputDecoration(
                      labelText: "Search here",
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  //Clear filter options
                  InkWell(
                    onTap: () {
                      //Call function to clear the filter and show listOfTask again
                      setState(() {
                        listOfTaskDisplay = listOfTaskGlobal;
                      });
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.delete),
                    ),
                  ),
                  //Add Data to list
                  InkWell(
                    onTap: () {
                      //Call a form to add data to the list
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Add event!"),
                              content: Column(
                                children: [
                                  TextFormField(
                                    controller: dateController,
                                    onChanged: (val) {
                                      date = val;
                                    },
                                    decoration: InputDecoration(
                                      hintText:
                                          'Enter Date in MM/DD/YYYY fromat',
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: descController,
                                    maxLines: 5,
                                    onChanged: (val) {
                                      desc = val;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Enter desc',
                                    ),
                                  ),
                                  (date != '' && desc != '')
                                      ? ElevatedButton(
                                          child: Text("Save Event"),
                                          onPressed: () {
                                            //Add logic to append the data to list
                                            TodoModel m = new TodoModel(
                                                date: date,
                                                eventDescription: desc);
                                            addToList(m);
                                            Navigator.pop(context);
                                          },
                                        )
                                      : Container()
                                ],
                              ),
                            );
                          });
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.add),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ListView.builder(
                  itemCount: listOfTaskDisplay.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Card(
                        child: Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: Text(
                                    listOfTaskDisplay[index].eventDescription)),
                            Expanded(
                                flex: 1,
                                child: Text(listOfTaskDisplay[index].date))
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        ));
  }
}
