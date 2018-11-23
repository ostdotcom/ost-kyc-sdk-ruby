# Kyc::Sdk::Ruby

A Ruby wrapper for the [KYC OST Developers API](https://dev.ost.com/docs/kyc/index.html).

## Requirements

To use this gem, developers will need to:
1. Login on [https://kyc.ost.com/admin/login](https://kyc.ost.com/admin/login).
2. Obtain an API Key and API Secret from [https://kyc.ost.com/admin/settings/developer-integrations](https://kyc.ost.com/admin/settings/developer-integrations).

## Documentation

[https://dev.ost.com/docs/kyc/index.html](https://dev.ost.com/docs/kyc/index.html)

## Installation

Install KYC Ruby SDK

```bash
> gem install kyc-sdk-ruby
```

## Example Usage

Require the KYC Ruby SDK:

```ruby
require('kyc-sdk-ruby')
```

Set variables for initializing SDK objects:

```ruby
ost_sdk = KYCSdk::Saas::Services.new({api_key: <api_key>, api_secret: <api_secret>, api_base_url: <api_base_url>})
```

### Users Module

```ruby
ost_user_object = ost_sdk.services.users
```

Create new user:

```ruby
ost_user_object.create(email: 'email@domain.com').to_json
```

Get an existing user:

```ruby
ost_user_object.get(id: 11007).to_json
```

Get a list of existing users and other data:

```ruby
ost_user_object.list().to_json
```

### Users Kyc Module

```ruby
ost_users_kyc_object = ost_sdk.services.users_kyc
```

Create/Update a new user kyc:

```ruby
## Params should have all the fields which are present in kyc config ##
params = {user_id: 11007, first_name:'YOGESH',  last_name:'SAWANT',  birthdate:'29/07/1992', country:'INDIA', nationality:'INDIAN', document_id_number:'DMDPS9634C', document_id_file_path:'10/i/4ae058629d4b384edcda8decdfbf0dd1', selfie_file_path:'10/i/4ae058629d4b384edcda8decdfbf0dd2', ethereum_address:'0x04d39e0b112c20917868ffd5c42372ecc5df577b',estimated_participation_amount:'1.2',residence_proof_file_path:'10/i/4ae058629d4b384edcda8decdfbf0dd3',investor_proof_files_path: ['10/i/4ae058629d4b384edcda8decdfbf0da1', '10/i/4ae058629d4b384edcda8decdfbf0da2'], city:'pune',street_address:'hadapsar',postal_code:'411028',state:'maharashtra'}
ost_users_kyc_object.kyc_submit(params).to_json
```

Get a list of existing users kyc and other data:

```ruby
ost_users_kyc_object.list().to_json
```

Get an existing user kyc:

```ruby
ost_users_kyc_object.get(user_id: '11007').to_json
```

Get an existing Presigned URL via POST call:

```ruby
ost_users_kyc_object.get_presigned_url_post().to_json
```

Get an existing Presigned URL via PUT call:

```ruby
ost_users_kyc_object.get_presigned_url_put().to_json
```

### Users Kyc Detail Module

```ruby
ost_user_kyc_detail_object = ost_sdk.services.users_kyc_detail
```

Get an user kyc detail:

```ruby
ost_user_kyc_detail_object.get(user_id: 11007).to_json
```

### Validators Module

```ruby
ost_validators_object = ost_sdk.services.validators
```

Verify Ethereum Address:

```ruby
ost_validators_object.verify_ethereum_address({ethereum_address: '0x7f2ED21D1702057C7d9f163cB7e5458FA2B6B7c4'}).to_json
```

### Request Specs

To obtain request/API specification, pass in `true` for the optional `api_spec` parameter when initializing SDK object:

```ruby
ost_sdk = KYCSdk::Saas::Services.new({api_key: <api_key>, api_secret: <api_secret>, api_base_url: <api_base_url>, api_spec: true})
ost_user_object = ost_sdk.services.users
```

And then call a method:

```ruby
ost_user_object.list().to_json
 {:success=>true, :data=>{:request_uri=>"http://kyc.ost.com:8080/api/v2/users", :request_type=>"GET", :request_params=>"request_timestamp=1542027534&signature=7d61d9494040858ff656a8e9361a3b5990ae969a30d123386069e58290f8e465&api_key=28ad8ebb00c8469e1e32156849e94b3f&page_number=1&order=asc&page_size=3"}}
 ```