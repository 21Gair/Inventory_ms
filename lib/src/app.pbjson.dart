//
//  Generated code. Do not modify.
//  source: app.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use operationTypeDescriptor instead')
const OperationType$json = {
  '1': 'OperationType',
  '2': [
    {'1': 'UPDATE', '2': 0},
    {'1': 'DELETE', '2': 1},
  ],
};

/// Descriptor for `OperationType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List operationTypeDescriptor = $convert.base64Decode(
    'Cg1PcGVyYXRpb25UeXBlEgoKBlVQREFURRAAEgoKBkRFTEVURRAB');

@$core.Deprecated('Use loginRequestDescriptor instead')
const LoginRequest$json = {
  '1': 'LoginRequest',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 9, '10': 'user'},
    {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

/// Descriptor for `LoginRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginRequestDescriptor = $convert.base64Decode(
    'CgxMb2dpblJlcXVlc3QSEgoEdXNlchgBIAEoCVIEdXNlchIaCghwYXNzd29yZBgCIAEoCVIIcG'
    'Fzc3dvcmQ=');

@$core.Deprecated('Use loginResponseDescriptor instead')
const LoginResponse$json = {
  '1': 'LoginResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'token', '3': 3, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `LoginResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginResponseDescriptor = $convert.base64Decode(
    'Cg1Mb2dpblJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIA'
    'EoCVIHbWVzc2FnZRIUCgV0b2tlbhgDIAEoCVIFdG9rZW4=');

@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor = $convert.base64Decode(
    'CgVFbXB0eQ==');

@$core.Deprecated('Use getCategoriesResponseDescriptor instead')
const GetCategoriesResponse$json = {
  '1': 'GetCategoriesResponse',
  '2': [
    {'1': 'categories', '3': 1, '4': 3, '5': 9, '10': 'categories'},
  ],
};

/// Descriptor for `GetCategoriesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCategoriesResponseDescriptor = $convert.base64Decode(
    'ChVHZXRDYXRlZ29yaWVzUmVzcG9uc2USHgoKY2F0ZWdvcmllcxgBIAMoCVIKY2F0ZWdvcmllcw'
    '==');

@$core.Deprecated('Use addProductRequestDescriptor instead')
const AddProductRequest$json = {
  '1': 'AddProductRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'category', '3': 2, '4': 1, '5': 9, '10': 'category'},
    {'1': 'price', '3': 3, '4': 1, '5': 1, '10': 'price'},
    {'1': 'quantity', '3': 4, '4': 1, '5': 5, '10': 'quantity'},
    {'1': 'productId', '3': 5, '4': 1, '5': 9, '10': 'productId'},
    {'1': 'image', '3': 6, '4': 1, '5': 12, '10': 'image'},
  ],
};

/// Descriptor for `AddProductRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addProductRequestDescriptor = $convert.base64Decode(
    'ChFBZGRQcm9kdWN0UmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1lEhoKCGNhdGVnb3J5GAIgAS'
    'gJUghjYXRlZ29yeRIUCgVwcmljZRgDIAEoAVIFcHJpY2USGgoIcXVhbnRpdHkYBCABKAVSCHF1'
    'YW50aXR5EhwKCXByb2R1Y3RJZBgFIAEoCVIJcHJvZHVjdElkEhQKBWltYWdlGAYgASgMUgVpbW'
    'FnZQ==');

@$core.Deprecated('Use addProductResponseDescriptor instead')
const AddProductResponse$json = {
  '1': 'AddProductResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AddProductResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addProductResponseDescriptor = $convert.base64Decode(
    'ChJBZGRQcm9kdWN0UmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use updateProductRequestDescriptor instead')
const UpdateProductRequest$json = {
  '1': 'UpdateProductRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'price', '3': 2, '4': 1, '5': 1, '10': 'price'},
    {'1': 'quantity', '3': 3, '4': 1, '5': 5, '10': 'quantity'},
    {'1': 'operation', '3': 4, '4': 1, '5': 14, '6': '.OperationType', '10': 'operation'},
  ],
};

/// Descriptor for `UpdateProductRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateProductRequestDescriptor = $convert.base64Decode(
    'ChRVcGRhdGVQcm9kdWN0UmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1lEhQKBXByaWNlGAIgAS'
    'gBUgVwcmljZRIaCghxdWFudGl0eRgDIAEoBVIIcXVhbnRpdHkSLAoJb3BlcmF0aW9uGAQgASgO'
    'Mg4uT3BlcmF0aW9uVHlwZVIJb3BlcmF0aW9u');

@$core.Deprecated('Use updateProductResponseDescriptor instead')
const UpdateProductResponse$json = {
  '1': 'UpdateProductResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateProductResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateProductResponseDescriptor = $convert.base64Decode(
    'ChVVcGRhdGVQcm9kdWN0UmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getProductsByCategoryRequestDescriptor instead')
const GetProductsByCategoryRequest$json = {
  '1': 'GetProductsByCategoryRequest',
  '2': [
    {'1': 'category', '3': 1, '4': 1, '5': 9, '10': 'category'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetProductsByCategoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getProductsByCategoryRequestDescriptor = $convert.base64Decode(
    'ChxHZXRQcm9kdWN0c0J5Q2F0ZWdvcnlSZXF1ZXN0EhoKCGNhdGVnb3J5GAEgASgJUghjYXRlZ2'
    '9yeRIUCgVsaW1pdBgCIAEoBVIFbGltaXQ=');

@$core.Deprecated('Use productDescriptor instead')
const Product$json = {
  '1': 'Product',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'category', '3': 2, '4': 1, '5': 9, '10': 'category'},
    {'1': 'price', '3': 3, '4': 1, '5': 1, '10': 'price'},
    {'1': 'quantity', '3': 4, '4': 1, '5': 5, '10': 'quantity'},
    {'1': 'productId', '3': 5, '4': 1, '5': 9, '10': 'productId'},
    {'1': 'image', '3': 6, '4': 1, '5': 12, '10': 'image'},
    {'1': 'imageUrl', '3': 7, '4': 1, '5': 9, '10': 'imageUrl'},
  ],
};

/// Descriptor for `Product`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List productDescriptor = $convert.base64Decode(
    'CgdQcm9kdWN0EhIKBG5hbWUYASABKAlSBG5hbWUSGgoIY2F0ZWdvcnkYAiABKAlSCGNhdGVnb3'
    'J5EhQKBXByaWNlGAMgASgBUgVwcmljZRIaCghxdWFudGl0eRgEIAEoBVIIcXVhbnRpdHkSHAoJ'
    'cHJvZHVjdElkGAUgASgJUglwcm9kdWN0SWQSFAoFaW1hZ2UYBiABKAxSBWltYWdlEhoKCGltYW'
    'dlVXJsGAcgASgJUghpbWFnZVVybA==');

@$core.Deprecated('Use getProductsByCategoryResponseDescriptor instead')
const GetProductsByCategoryResponse$json = {
  '1': 'GetProductsByCategoryResponse',
  '2': [
    {'1': 'products', '3': 1, '4': 3, '5': 11, '6': '.Product', '10': 'products'},
  ],
};

/// Descriptor for `GetProductsByCategoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getProductsByCategoryResponseDescriptor = $convert.base64Decode(
    'Ch1HZXRQcm9kdWN0c0J5Q2F0ZWdvcnlSZXNwb25zZRIkCghwcm9kdWN0cxgBIAMoCzIILlByb2'
    'R1Y3RSCHByb2R1Y3Rz');

