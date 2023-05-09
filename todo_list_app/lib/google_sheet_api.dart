import 'package:gsheets/gsheets.dart';

class GoogleSheetApi {
  /// Your google auth credentials
  /// how to get credentials - https://medium.com/@a.marenkov/how-to-get-credentials-for-google-sheets-456b7e88c430
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "flutter-project-383800",
  "private_key_id": "ddf19c84d2ad83dde485de4050fb6b7fba4e38a8",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDe8ZxufceD7CKD\n4ngfi8c1EXYLSNyyPGo3n2T4Fo2KbnW3RYjhZFagV3TnoJgdvk2en6N7n6af1ZSu\nHOSr5V11KzHQJHIgSzNTP8fQtKLHNBz5T71F8Nwnt3ioJPEv6wALPBGssDdCRt2f\no+1sufD8rlccCnDMpel2jq2vknYsw5+0z7N6O9PaqpticlRNLx6tchgiygY2MvZ4\nGdQsRhtmbhqmK686rUFMEwJS6ZlGZW6/TYSiYpwLIcfuPRfK290nTzIxsN/sO/a8\ny7RpMrKQ+cM3d1FpX5UlRP9+urm3XE866rwOPbcVoGLkqj2AQMqpp6pcXNGhSCs9\nddku7Hr5AgMBAAECggEABpOqFw2u171yPIxvGWnOM/U9Pj1QBWddhXaLoVCeVvnF\n5I+F54rw40SxNi65ThH8ct7Su9A3N3qIKvq/OYhH/C+MsKSNRAFJP6jKBDt6nIB1\nD7BtLPsGA5tDUUfbCvGBIX5hfG6rsqYp3jkVGqKsRp1TWd2/ph80MUMplzGtkB8c\ne4nXRe7G7wMmMjDHalLhnsISHp6qxtdLgDWfyXKRAMgSNWiFOmRYWWoCcGXbhCib\nZtROgZjemz4g8xhjJXQYrEb708r1HjeY596zUYPJl76oQgrFKanGYyeN0j8bVgoc\nRTgjb2tYhPy7rT6W9k3eTLXEogaxjHCn39EaewCdYQKBgQDyfPVM/na8E96i1QiN\nkY/Abje5SrQZ+UDFULZfYv7oRrnwrDFPwhbfm1D5G3RwSkuiXYs//VISNhyWmkn2\n47h8Fs4p/immrVmeMo7RcC/oM+E55szmrY49fkutTqr8MFdWTciExZU9a4zOEGTv\nDmiwOE00wuL3pTzO/QEQzWKz5wKBgQDrXdtwwOIb9BJBSnWRtas0XRsuYKHrgjuu\nN9XcuLlH3eJgsCvPubQITIRwW29YYwOcbzclJJ4bHouF6SKtXvDHxKHbV7SnQiTY\nbxncPDgM/E/5KALMTzPaADqEFwt4WAqrVRGIjmGCcqZibTevQNRQ1Rias98Sa1VL\nPYB764t+HwKBgQDeLcBUm5MPIOWNLMR5cjXUiyhjjh8W7Vp7cEipfXsyOBuGeT91\nZNCwcQ7wMEev22MRkcRVDTZ1mT74fsXmgSA4Em0z7L0dCxhh6tEQ9Unv6BklhGOZ\nuMvrbBzK3pmsGF7tpLdlb+QeMr0A0eSpZPpm/C9BeI+deLkOrqKbUpRtYQKBgBWV\ng9wxNAsQNORb6bA1EsA4kZeNMQwh40s0v54AKq2WgX4QadQg2YuxSKvtFqbqXZho\n8ourcfxWrsDXAmEXxcjsFVPCFUUJYcufVKXHt/Qo50SYELmfwceKIdOfMWQV3tSb\ndoIpXHPUA8Ie9e5SaaYIBLubJyfPRAEkYLX8gcxNAoGBAJLte4HkafqEdwEk8OcU\nFCU8ck+fXt6SR5K8X4djxDTEwXYL2jh16g+l5q2EQMqxe1QplI8d0F/R+beW/5vU\nIOsDogZ4I+BDSgQvrons6G9zWIYsCrLIwVxWkMnPThAmqX/NOkgAY4NMnnIBkg4N\nBaLBcNVsp9XZXMbFK4du0SST\n-----END PRIVATE KEY-----\n",
  "client_email": "flutter-project@flutter-project-383800.iam.gserviceaccount.com",
  "client_id": "116752176751887011264",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-project%40flutter-project-383800.iam.gserviceaccount.com"
}
''';

  /// Your spreadsheet id
  /// It can be found in the link to your spreadsheet -
  /// link looks like so https://docs.google.com/spreadsheets/d/YOUR_SPREADSHEET_ID/edit#gid=0

  static const _spreadsheetId = '1NxkuGyb4fZ5kxjmOnVRv1gBZ5KTVTkuU4GRM2JSUtMo';

  //initialize GSheets
  static final _gsheets = GSheets(_credentials);

  //fetch spread by its ID
  static Worksheet? _worksheet;

//Variable to keep track off..
  static int numberOfNotes = 0;
  static List<List<dynamic>> currentNotes = [
      
  ];
  static bool loading = true;
  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);

    // Get the word sheets  by its title
    _worksheet = ss.worksheetByTitle('Wordsheet1');
    countRows();
  }

//count number of rows
  static Future countRows() async {
    while (
        (await _worksheet!.values.value(column: 1, row: numberOfNotes + 1)) !=
            '') {
      numberOfNotes++;
    }
    loadNotes();
  }

//load the existing data in spreedsheet
  static Future loadNotes() async {
    if (_worksheet == null) return;

    for (int i = 0; i < numberOfNotes; i++) {
      final String newNote =
          await _worksheet!.values.value(column: 1, row: i + 1);
      if (currentNotes.length < numberOfNotes) {
        currentNotes.add([
          newNote,
          int.parse(await _worksheet!.values.value(column: 2, row: i + 1))
        ]);
      }
    }
    loading = false;
  }

//insert method
  static Future insert(String note) async {
    if (_worksheet == null) return;
    numberOfNotes++; 
    currentNotes.add([note, 0]);
    await _worksheet!.values.appendRow([note, 0]);
  }

  static Future update(int index, int isTaskCompleted) async {
    _worksheet!.values.insertValue(isTaskCompleted, column: 2, row: index + 1);
  }
}
