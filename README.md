# THETA X Bloc App

![overall gif](docs/images/overall.gif)

This application utilizes Bloc to handle state management. The connection to the camera is 
handled by the http package inside of the Bloc. The application shows the use of commands such as [listFiles](https://api.ricoh/docs/theta-web-api-v2.1/commands/camera.list_files/) from the THETA Web API. 

```dart
var url = Uri.parse('http://192.168.1.1/osc/commands/execute');
    var header = {'Content-Type': 'application/json;charset=utf-8'};
    var bodyMap = {
    'name': 'camera.listFiles',
    'parameters': {
        'fileType': 'image',
        'startPosition': 0,
        'entryCount': 1,
        'maxThumbSize': 0
    }
    };
    var bodyJson = jsonEncode(bodyMap);
    var response = await http.post(url, headers: header, body: bodyJson);
    var thetaFiles = jsonDecode(response.body);
    var fileUrl = thetaFiles['results']['entries'][0]['fileUrl'];
    emit(ThetaState(message: fileUrl));
```

## Workarounds 

For the THETA X, the `thumbnail` does not appear unless the `_detail` is set to true. The thumbnail only works for a single file. If we need to get multiple thumbnails, then the `startPosition` needs to be changed to a different number and run multiple times. 

Another technique is to get the list of file urls and pass it `fileUrl = fileUrl + "?type=thumb";`. This technique will also show the thumbnail. 

## Bloc Structure

The Bloc structure helps to manage the state across an application and handle events. Previously, I created an application using `setState()`, however, this approach is not very scalable as our application becomes more complex. With the use of Bloc, we can separate out the events and ensure that every file can access the state. The Bloc state management comes from the Flutter [package](https://pub.dev/packages/flutter_bloc). 

### Event

Events in Bloc are executed when an action occurs. For each separate button in the application, I created a specific event. The `GetInfoEvent` below connects to the Info button.

```dart
class GetInfoEvent extends ThetaEvent {}
```
### State

The State is emitted in the Bloc file and holds information in parameters. The State extends [Equatable](https://pub.dev/packages/equatable). When the state changes, the screen updates.

### Bloc

Inside of the Bloc file, I have a series of `on` methods that pair an Event with the State. Basically, when an Event occurs, such as tapping on the Info button, the app will get the response from the camera. Next, it passes the response into the State, therefore displaying our text.

```dart
    on<GetInfoEvent>((event, emit) async {
      var url = Uri.parse('http://192.168.1.1/osc/info');
      var response = await http.get(url);
      var encoder = JsonEncoder.withIndent('  ');
      var formattedResponse = encoder.convert(jsonDecode(response.body));
      emit(ThetaState(message: formattedResponse));
    });
```

<img src="docs/images/response.png" width= 55%>

## ListView

The Show List Images button displays a list of thumbnail images. I created a `ListView` widget that uses the `urlList` to create the images. The list of urls can be accessed once we wrap our widget with a `BlocBuilder`. For the `ListView` widget, I assigned the length to be the length of the `urlList`. Additionally, an Image is created from each item inside of the urlList.
                                        
```dart
 return ListView.builder(
    itemCount: state.urlList.length,
    itemBuilder: ((context, index) {
    var fileUrl = state.urlList[index];
    return InkWell(
        child: Image.network('${state.urlList[index]}?type=thumb'));
    }));
```


### Panorama

I imported the [Panorama](https://pub.dev/packages/panorama) package into the file that displays the full image once the user clicks on the thumbnail. The `Panorama` widget wraps around the `Image.network`. 

```dart
        body: Panorama(child: Image.network(fileUrl));
```
![panorama of app](docs/images/panorama.gif)

## Shooting Settings

The Shooting Settings screen on the application has several buttons that can switch between video or image mode. There are other specific settings for the image (5.5K and 11K) and the video (8K 2fps and 8K 5fps). Similarly to the other buttons, the shooting settings buttons each have their own event which is handled in the Bloc file. 

### Shooting Settings Features

* [captureMode](https://api.ricoh/docs/theta-web-api-v2.1/options/capture_mode/)
* [fileFormat](https://api.ricoh/docs/theta-web-api-v2.1/options/file_format/)

![shooting settings](docs/images/shooting.gif)
<img src="docs/images/shooting_settings.png" width=35%>

We can change the `fileFormat` inside of the State with these parameters:

### Parameters for Image

11K Image {“type”: “jpeg”,”width”: 11008,”height”: 5504}

5.5K Image {“type”: “jpeg”,”width”: 5504,”height”: 2752}

### Parameters for Video

8K 5fps Video {“type”: “mp4”,”width”: 7680,”height”: 3840, “_codec”: “H.264/MPEG-4 AVC”, “_frameRate”: 5}

8K 2fps Video {“type”: “mp4”,”width”: 7680,”height”: 3840, “_codec”: “H.264/MPEG-4 AVC”, “_frameRate”: 2}

Once the camera's file format is set, the camera's display changes:

<img src="docs/images/video8K.JPG" width=60%>
