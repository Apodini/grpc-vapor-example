# Implementation Example

## Overview
This is an implementation example of the gRPC-vapor Framework and the grpc-vapor Generator.
This server application provides either a REST or a gRPC interface to client applications like the client-example.

## Idea of Implementation Example
The idea of this implementation example is a SmartHome thermostat system where the server manages thermostats and stores their measurement and offers different services.
The client can request the thermostat instances & measurements, upload measurements and use the server to calculate measurement statistics.
These requests are initiated in the clients `main.swift` file.

This implementation example offers five REST endpoints / gRPC remote procedure calls:
- getThermostatIds: has no inputs and returns an array (REST) or stream (gRPC) of thermostat Ids (string)
- getThermostatWithId: gets an id of a thermostat and returns a single thermostat
- getMeasurements: gets an id of a thermostat and returns all the thermostats measurements
- uploadMeasurements: gets either a single (REST) masurement or a stream (gRPC) masurements saves the measurement in the Fluent database and then returns the uploaded measurement(s) with their new id
- calculateStatistics: gets either an array (REST) or a stream (gRPC) of measurements and returns a MeasurementStats object that calculated the minimum, maximum and average of the received measurements.  

## Current Problems
Currently this example doesn't work that seemlessly. Here are the most important remaining issues:
- Switching from gRPC to REST calls requires the server to disable TLS encryption and HTTP/2 support (marked in configure.swift) as the REST client doesn't support yet encrpyting REST requests and Vapor only supports encrypted HTTP/2 requests 
- To set up the server and client they both need to have the certificates and keys in their working directories. I recommend using custom working directories and the self-signed certificate & key sent via Slack.
- Currently when using call types that have server-side streaming the client doesn't get the end message from the server although it seems like the server sends it. (For this reason all responses from calls get printed on the client side so that the individual server messages can be checked.    
- This example and the framework require Swift version 5.2 as Vapor 4 is based on this version.
- The grpc-vapor framework currently uses an old version of swift-grpc as the newer version made two important classes internal that need to be replaced soon.

## Usage of Generator
The generator should be used by running grpc-vapor-example executable from the grpc-vapor repository like with the following arguments:

    `codegen --inputPath={Path of repository} --outpuTPath={Path to target directory or subdirectory}`
    
This generator generates:
- An `application.proto` specification file
- A service extension
- Model mappings that currently still have some issues with optionals and integers. Therfore I recommend using the model mappings provided with this repository

To generate the proto message types the user needs to use the protoc compiler with the swift plugin like this:

    `protoc application.proto --swift_out=.` 
