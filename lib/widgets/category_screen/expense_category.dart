import 'package:auto_size_text/auto_size_text.dart';
import 'package:bhandaram/db/category/category_db.dart';
import 'package:bhandaram/models/category/category_model.dart';
import 'package:flutter/material.dart';

class ExpenseCategoryList extends StatefulWidget {
  const ExpenseCategoryList({Key? key}) : super(key: key);

  @override
  State<ExpenseCategoryList> createState() => _ExpenseCategoryListState();
}

class _ExpenseCategoryListState extends State<ExpenseCategoryList> {
  @override
  Widget build(BuildContext context) {
    
    return ValueListenableBuilder(
        valueListenable: CategoryDB().expenseCategoryListListener,
        builder: (BuildContext context, List<CategoryModel> newList, Widget? _) {
          return CategoryDB().expenseCategoryListListener.value.isEmpty?
           Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AutoSizeText('No category added',style: TextStyle(fontSize: 17,color: Colors.grey[600]),maxFontSize: 17,minFontSize: 5,maxLines: 1,),
             AutoSizeText('(eg : Food , Fuel...)',style: TextStyle(fontSize: 17,color: Colors.grey[600]),maxFontSize: 17,minFontSize: 5,maxLines: 1,)]
          
          ):
          ListView.separated(
            itemBuilder: (ctx, index) {
              final category=newList[index];
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  shadowColor: Colors.grey[400],
                  color: const Color.fromARGB(255, 139, 181, 204),
                  elevation: 3,
                  child: ListTile(
                     shape: RoundedRectangleBorder(side: const BorderSide(color: Color.fromARGB(255, 109, 106, 106), width: 1), borderRadius: BorderRadius.circular(5)),
                        title: Text(category.name,style: const TextStyle(fontSize: 19),),
                        trailing: IconButton(
                          onPressed: () {
                            showDialog(context: context, builder: (ctx)=>AlertDialog(
                        content:const Text("Do you wanted to delete this category?"),
                        actions: <Widget>[
                          TextButton(onPressed: (){
                             setState(() {
                         CategoryDB.instance.deleteCategory(category.id);
    
                       
                          Navigator.of(context).pop();
                                  // ignore: deprecated_member_use
                      Scaffold.of(context).showSnackBar(const SnackBar(
                        duration: Duration(seconds: 1),
                       backgroundColor: Color.fromARGB(255, 238, 93, 83),
                          content: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text("You have deleted this category",style: TextStyle(color: Colors.white,fontSize: 17),),
                          )));
                      });            
                          }, child: const Text("OK")),
                          TextButton(onPressed:(){
                      
                            Navigator.of(context).pop();
                          } , child: const Text("Cancel"))
    
                        ],
                      ));
                              
                     
                           
                          },
                          icon: const Icon(Icons.delete,color: Color.fromARGB(255, 221, 94, 85),),
                        ),
                      )
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 0,
              );
            },
            itemCount: newList.length,
          );
        });
  }
}
