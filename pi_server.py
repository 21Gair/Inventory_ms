import grpc
from concurrent import futures
import your_proto_file_pb2
import your_proto_file_pb2_grpc

class ProductService(your_proto_file_pb2_grpc.ProductServiceServicer):
    def AddProduct(self, request, context):
        response = your_proto_file_pb2.AddProductResponse()
        response.message = "Product added successfully"
        # Implement your logic to add product here
        return response

def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    your_proto_file_pb2_grpc.add_ProductServiceServicer_to_server(ProductService(), server)
    server.add_insecure_port('[::]:50051')
    server.start()
    server.wait_for_termination()

if __name__ == '__main__':
    serve()
