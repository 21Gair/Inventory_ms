//
//  Generated code. Do not modify.
//  source: app.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'app.pb.dart' as $0;

export 'app.pb.dart';

@$pb.GrpcServiceName('productService')
class productServiceClient extends $grpc.Client {
  static final _$login = $grpc.ClientMethod<$0.LoginRequest, $0.LoginResponse>(
      '/productService/login',
      ($0.LoginRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.LoginResponse.fromBuffer(value));
  static final _$getCategories = $grpc.ClientMethod<$0.Empty, $0.GetCategoriesResponse>(
      '/productService/GetCategories',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetCategoriesResponse.fromBuffer(value));
  static final _$addProduct = $grpc.ClientMethod<$0.AddProductRequest, $0.AddProductResponse>(
      '/productService/addProduct',
      ($0.AddProductRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AddProductResponse.fromBuffer(value));
  static final _$updateProduct = $grpc.ClientMethod<$0.UpdateProductRequest, $0.UpdateProductResponse>(
      '/productService/updateProduct',
      ($0.UpdateProductRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateProductResponse.fromBuffer(value));
  static final _$getProductsByCategory = $grpc.ClientMethod<$0.GetProductsByCategoryRequest, $0.GetProductsByCategoryResponse>(
      '/productService/GetProductsByCategory',
      ($0.GetProductsByCategoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetProductsByCategoryResponse.fromBuffer(value));

  productServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.LoginResponse> login($0.LoginRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$login, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCategoriesResponse> getCategories($0.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCategories, request, options: options);
  }

  $grpc.ResponseFuture<$0.AddProductResponse> addProduct($0.AddProductRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addProduct, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateProductResponse> updateProduct($0.UpdateProductRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateProduct, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetProductsByCategoryResponse> getProductsByCategory($0.GetProductsByCategoryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getProductsByCategory, request, options: options);
  }
}

@$pb.GrpcServiceName('productService')
abstract class productServiceBase extends $grpc.Service {
  $core.String get $name => 'productService';

  productServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.LoginRequest, $0.LoginResponse>(
        'login',
        login_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.LoginRequest.fromBuffer(value),
        ($0.LoginResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.GetCategoriesResponse>(
        'GetCategories',
        getCategories_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.GetCategoriesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AddProductRequest, $0.AddProductResponse>(
        'addProduct',
        addProduct_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AddProductRequest.fromBuffer(value),
        ($0.AddProductResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateProductRequest, $0.UpdateProductResponse>(
        'updateProduct',
        updateProduct_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateProductRequest.fromBuffer(value),
        ($0.UpdateProductResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetProductsByCategoryRequest, $0.GetProductsByCategoryResponse>(
        'GetProductsByCategory',
        getProductsByCategory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetProductsByCategoryRequest.fromBuffer(value),
        ($0.GetProductsByCategoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.LoginResponse> login_Pre($grpc.ServiceCall call, $async.Future<$0.LoginRequest> request) async {
    return login(call, await request);
  }

  $async.Future<$0.GetCategoriesResponse> getCategories_Pre($grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return getCategories(call, await request);
  }

  $async.Future<$0.AddProductResponse> addProduct_Pre($grpc.ServiceCall call, $async.Future<$0.AddProductRequest> request) async {
    return addProduct(call, await request);
  }

  $async.Future<$0.UpdateProductResponse> updateProduct_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateProductRequest> request) async {
    return updateProduct(call, await request);
  }

  $async.Future<$0.GetProductsByCategoryResponse> getProductsByCategory_Pre($grpc.ServiceCall call, $async.Future<$0.GetProductsByCategoryRequest> request) async {
    return getProductsByCategory(call, await request);
  }

  $async.Future<$0.LoginResponse> login($grpc.ServiceCall call, $0.LoginRequest request);
  $async.Future<$0.GetCategoriesResponse> getCategories($grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.AddProductResponse> addProduct($grpc.ServiceCall call, $0.AddProductRequest request);
  $async.Future<$0.UpdateProductResponse> updateProduct($grpc.ServiceCall call, $0.UpdateProductRequest request);
  $async.Future<$0.GetProductsByCategoryResponse> getProductsByCategory($grpc.ServiceCall call, $0.GetProductsByCategoryRequest request);
}
