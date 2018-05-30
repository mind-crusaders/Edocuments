# Project Description

This application allow people to securely upload and store all identity related documents which can include passport, drivers licence, birth certificate, and many more. Our platform will allow users to securely send relevant documnets to government services whenever they require certain services.The following are some of the features of the application. More special and unique features will be added as the development of the application continues;

1. Provide a platform for sercurely storing your identity-related documents.
2. Allow users to send documents to relevent goverment offices for passport application.
3. Users will be able to keep  track of who is accessing their documents.


# Edocument API

API to store and retrieve confidential development files.

## Basic

All routes return Json

- GET `/`: Root route shows if Web API is running
- GET `api/v1/document/`: returns all confiugration IDs
- GET `api/v1/document/[ID]`: returns details about a single document with given ID
- POST `api/v1/document/`: creates a new document

## Install

Install this API by cloning the *relevant branch* and installing required gems from `Gemfile.lock`:

```shell
bundle install
```

## Test

Run the test script:

```shell
ruby spec/api_spec.rb
```

## Execute

Run this API using:

```shell
rackup
```

## Logo

<p align="center">
  <<a href="https://ibb.co/nkOsTn"><img src="https://image.ibb.co/gijcuS/240_F_157145617_I0_Dv_ZCovewd9kup_Hpj_C21_Mrfe_C6_M9i2_I.jpg" alt="Logo" border="0"></a>
  
</p>
