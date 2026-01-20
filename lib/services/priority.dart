import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shehram_backend/models/priority.dart';

class PriorityServices{
  String priorityCollection = "PriorityCollection";
  ///Create Priority
  Future createPriority(PriorityTaskModel model)async{
    DocumentReference documentReference = await FirebaseFirestore.instance
        .collection(priorityCollection)
        .doc();
    return await FirebaseFirestore.instance
        .collection(priorityCollection)
        .doc(documentReference.id)
        .set(model.toJson(documentReference.id));
  }
  ///Update Priority
  Future updatePriority(PriorityTaskModel model)async{
    return await FirebaseFirestore.instance
        .collection(priorityCollection)
        .doc(model.docId)
        .update({"name" : model.name,});
  }
  ///Delete Priority
  Future deletePriority(String priorityID)async{
    return await FirebaseFirestore.instance
        .collection(priorityCollection)
        .doc(priorityID)
        .delete();
  }

  ///get All Priority
  Stream<List<PriorityTaskModel>> getAllPriority(){
    return FirebaseFirestore.instance
        .collection(priorityCollection)
        .snapshots()
        .map((priorityList)=> priorityList.docs
        .map((priorityJson) => PriorityTaskModel.fromJson(priorityJson.data())).toList(),
    );
  }

  ///get Priority
  Future<List<PriorityTaskModel>> getPriority(){
    return FirebaseFirestore.instance
        .collection(priorityCollection)
        .get()
        .then((priorityList)=> priorityList.docs
        .map((priorityJson) => PriorityTaskModel.fromJson(priorityJson.data())).toList(),
    );
  }

}