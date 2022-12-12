// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:motsha_app/service/get_division_list.dart';
// import 'package:motsha_app/service/http_service.dart';
// import '../const/toast_message.dart';
//
// class FishersRegistration extends StatefulWidget {
//   const FishersRegistration({Key? key}) : super(key: key);
//
//   @override
//   State<FishersRegistration> createState() => _FishersRegistrationState();
// }
//
// class _FishersRegistrationState extends State<FishersRegistration> {
//   final GlobalKey<FormState> _key=GlobalKey<FormState>();
//   String? _selectedDivision;
//   TextEditingController fishermanNameBngController = TextEditingController();
//   TextEditingController fishermanNameEngController = TextEditingController();
//   TextEditingController nationalIdController = TextEditingController();
//   TextEditingController mobileController = TextEditingController();
//   TextEditingController genderController = TextEditingController();
//   TextEditingController dateOfBirthController = TextEditingController();
//   TextEditingController mothersNameController = TextEditingController();
//   TextEditingController fathersNameController = TextEditingController();
//   TextEditingController divisionIdController = TextEditingController();
//   TextEditingController districtIdController = TextEditingController();
//   TextEditingController upazillaIdController = TextEditingController();
//   TextEditingController postOfficeIdController = TextEditingController();
//   TextEditingController imageController = TextEditingController();
//
//   File? image;
//   Future takeImage() async {
//     try {
//       final image = await ImagePicker().pickImage(source: ImageSource.camera);
//
//       if (image == null) return;
//       final imageTemp = File(image.path);
//       setState(() => this.image = imageTemp);
//     } on PlatformException catch (e) {
//       print("Failed to pick image :$e");
//     }
//   }
//
//   bool onProgress = false;
//   Future addFisherman() async {
//     var link = Uri.parse("http://dof-demo.rdtl.xyz/api/fisher/add-data");
//     var request = http.MultipartRequest("POST", link);
//     request.headers.addAll(await HttpService.defaultHeader);
//     request.fields["fishermanNameBng"] =
//         fishermanNameEngController.text.toString();
//     request.fields["fishermanNameEng"] =
//         fishermanNameBngController.text.toString();
//     request.fields["nationalId"] = nationalIdController.text.toString();
//     request.fields["mobile"] = mobileController.text.toString();
//     request.fields["gender"] = genderController.text.toString();
//     request.fields["mothersName"] = mothersNameController.text.toString();
//     request.fields["fathersName"] = fathersNameController.text.toString();
//     request.fields["divisionId"] = divisionIdController.text.toString();
//     request.fields["districtId"] = districtIdController.text.toString();
//     request.fields["upazillaId"] = upazillaIdController.text.toString();
//     request.fields["postOfficeId"] = postOfficeIdController.text.toString();
//     request.fields["dateOfBirth"] = dateOfBirthController.text.toString();
//     var imageFile = await http.MultipartFile.fromPath("image", image!.path);
//     request.files.add(imageFile);
//     setState(() {
//       onProgress = true;
//     });
//     var response = await request.send();
//     var status = response.statusCode;
//     print("ssssssssssssssssss $status");
//     setState(() {
//       onProgress = false;
//     });
//     var responseDataByte = await response.stream.toBytes();
//     var responseDataString = String.fromCharCodes(responseDataByte);
//     var data = jsonDecode(responseDataString);
//     if (response.statusCode == 200) {
//       showInToast("${data["message"]}");
//       Navigator.of(context).pop();
//     } else {
//       showInToast("${data["message"]}");
//     }
//
//     Navigator.of(context).pop();
//   }
//
//   @override
//   void didChangeDependencies() async{
//     // TODO: implement didChangeDependencies
//     super.didChangeDependencies();
//     await GetDivisionList().fetchDivision();
//     setState(() {
//
//     });
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     fishermanNameBngController.dispose();
//     fishermanNameEngController.dispose();
//     nationalIdController.dispose();
//     mobileController.dispose();
//     genderController.dispose();
//     dateOfBirthController.dispose();
//     mothersNameController.dispose();
//     fathersNameController.dispose();
//     divisionIdController.dispose();
//     districtIdController.dispose();
//     upazillaIdController.dispose();
//     postOfficeIdController.dispose();
//     imageController.dispose();
//
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Center(
//           child: Form(
//             key: _key,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 DropdownButton<String>(
//                   hint: Text("Select Division"),
//                   value: _selectedDivision,
//                   icon: const Icon(Icons.arrow_downward),
//                   elevation: 16,
//                   style: const TextStyle(color: Colors.deepPurple),
//                   underline: Container(
//                     height: 2,
//                     color: Colors.deepPurpleAccent,
//                   ),
//                   onChanged: (String? value) {
//                     // This is called when the user selects an item.
//                     setState(() {
//                       _selectedDivision = value!;
//                     });
//                     print(_selectedDivision);
//                   },
//                   items: GetDivisionList.divisionListData.map<DropdownMenuItem<String>>((list) {
//                     return DropdownMenuItem<String>(
//                       value: list.divisionEng,
//                       child: Text("${list.divisionEng}"),
//                     );
//                   }).toList(),
//                 ),
//
//                 Padding(
//                   padding:
//                   const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
//                   child: TextFormField(
//                     controller: fishermanNameBngController,
//                     validator: (value) {
//                       if(value== null || value.isEmpty)
//                         return "Field is required";
//                       return null;
//                     },
//                     decoration: InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.green),
//                         ),
//                         labelText: "জেলের নাম",
//                         hintText: "জেলের নাম",
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             gapPadding: 4.0,
//                             borderSide:
//                             BorderSide(color: Color(0xFF642E4C), width: 30))),
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     takeImage();
//                   },
//                   child: image == null
//                       ? Container(
//                     height: MediaQuery.of(context).size.height * .25,
//                     width: MediaQuery.of(context).size.width * .5,
//                     color: Colors.green.withOpacity(.35),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(25),
//                       child: Icon(
//                         Icons.camera_alt_outlined,
//                         size: 80,
//                         color: Colors.green,
//                       ),
//                     ),
//                   )
//                       : Image.file(
//                     File(image!.path),
//                     height: 200,
//                     width: 250,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: Container(
//                         height: 40,
//                         width: 80,
//                         decoration: BoxDecoration(
//                             color: Colors.green,
//                             borderRadius: BorderRadius.circular(13)),
//                         child: InkWell(
//                           onTap: () {
//                             if(_key.currentState!.validate()){
//                               _key.currentState!.save();
//                             }
//                             if(image == null){
//                               showInToast("Please Upload an Image");
//                             }
//                             //addFisherman();
//                           },
//                           child: Center(
//                             child: Text(
//                               "Submit",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ))),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
