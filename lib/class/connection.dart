import 'package:grpc/grpc.dart';

class GrpcClientService {
  static final GrpcClientService _instance = GrpcClientService._internal();

  factory GrpcClientService() {
    return _instance;
  }

  GrpcClientService._internal();

  ClientChannel createChannel() {
    return ClientChannel(
      '172.27.160.1', // Replace with your server's IP address
      port: 50051,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );
  }
}
