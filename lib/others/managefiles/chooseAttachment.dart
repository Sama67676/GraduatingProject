import 'package:flutter/material.dart';

import 'chatRoomAudio.dart';
import 'chatRoomImages.dart';
import 'chatRoomPdf.dart';
import 'chatRoomVideo.dart';
class ChooseAttachement {
  void chooseAttachmentType(context, chatRoomId,currentUser, frienduid){
showModalBottomSheet(context: context, builder: (BuildContext bc){
  return Container(
    height: MediaQuery.of(context).size.height * .30,
    child: Column(
      children: [
        Expanded(
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.only(left:35, right: 35, top: 35,bottom: 5),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: (){
                      SendImage sendImage = SendImage();
                      sendImage.pickImagefromGalery(context, chatRoomId, currentUser, frienduid);
                    },
                     style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
              ),child: const Icon(Icons.image, size: 30,),
                  ),
                  const SizedBox(height: 4,),
                  const Text('Image', style: TextStyle(fontSize: 15),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:35, right: 35, top: 35,bottom: 5),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: (){
                      SendPdfs sendPdfs = SendPdfs();
                      sendPdfs.pickpdfs(chatRoomId,currentUser, frienduid);
                    },
                     style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
              ),child: const Icon(Icons.file_copy, size: 30,),
                  ),
                  const SizedBox(height: 4,),
                  const Text('file', style: TextStyle(fontSize: 15),)
                ],
              ),
            ),
            Padding(
              padding:const EdgeInsets.only(left:35, right: 35, top: 35,bottom: 5),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: (){
                      SendImage sendImage = SendImage();
                      sendImage.pickImagefromcamera(context, chatRoomId, currentUser, frienduid);
                    },
                     style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
              ),child: const Icon(Icons.camera_alt, size: 30,),
                  ),
                  const SizedBox(height: 4,),
                  const Text('Camera', style: TextStyle(fontSize: 15),)
                ],
              ),
            )
      ]), 
        ),
        Expanded(
          child: Row(children: [
            Padding(
                padding: const EdgeInsets.only(left:35, right: 35, bottom: 35,top: 5),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        SendAudio sendAudio = SendAudio();
                        sendAudio.pickAudio(context, chatRoomId, currentUser, frienduid);
                      },
                       style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(15),
                ),child: const Icon(Icons.headphones, size: 30,),
                    ),
                    const SizedBox(height: 4,),
                    const Text('audio', style: TextStyle(fontSize: 15),)
                  ],
                ),
              ),
              Padding(
              padding: const EdgeInsets.only(left:35, right: 35, bottom: 35,top: 5),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: (){
                      SendVideo sendVideo = SendVideo();
                      sendVideo.pickVideo(context, chatRoomId, currentUser, frienduid);
                    },
                     style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
              ),child: const Icon(Icons.video_call, size: 30,),
                  ),
                  const SizedBox(height: 4,),
                  const Text('Video', style: TextStyle(fontSize: 15),)
                ],
              ),
            )
          ],),
        )
      ],
    ),
  );
});
}
}