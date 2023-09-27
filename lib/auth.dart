import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('6514426ecc07f38d46b7')
    .setSelfSigned(status: true); // For self signed certificates, only use for development
