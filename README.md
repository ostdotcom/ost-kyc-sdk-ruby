# OstKyc::Sdk::Ruby

A Ruby wrapper for the [OST KYC Developers API](https://dev.ost.com/docs/kyc/index.html).

## Requirements

To use this gem, developers will need to:
1. Login on [https://kyc.ost.com/admin/login](https://kyc.ost.com/admin/login).
2. Obtain an API Key and API Secret from [https://kyc.ost.com/admin/settings/developer-integrations](https://kyc.ost.com/admin/settings/developer-integrations).

## Documentation

[https://dev.ost.com/docs/kyc/index.html](https://dev.ost.com/docs/kyc/index.html)

## Installation

Install OST KYC Ruby SDK

```bash
> gem install ost-kyc-sdk-ruby
```

## Example Usage

Require the OST KYC Ruby SDK:

```ruby
require('ost-kyc-sdk-ruby')
```

Set variables for initializing SDK objects:

```ruby
# The config field is optional for ost_kyc_sdk object
CONFIG = {timeout: 10}
# The timeout in the config is the timeout in seconds for which the socket connection will remain open
ost_kyc_sdk = OstKycSdkRuby::Saas::Services.new({api_key: <OST_KYC_API_KEY>, api_secret: <OST_KYC_API_SECRET>, api_base_url: <OST_KYC_API_ENDPOINT>, config: <CONFIG>})
```

### Users Module

```ruby
ost_kyc_user_object = ost_kyc_sdk.services.users
```

Create new user:

```ruby
ost_kyc_user_object.create(email: 'email1@domain.com').to_json
```

Get an existing user:

```ruby
ost_kyc_user_object.get(id: 11007).to_json
```

Get a list of existing users and other data:

```ruby
ost_kyc_user_object.list().to_json
```

### Users Kyc Module

```ruby
ost_kyc_users_kyc_object = ost_kyc_sdk.services.users_kyc
```

Create/Update a new user kyc:

```ruby
## Params should have all the fields which are present in kyc config ##
params = {user_id: 11007, first_name:'YOGESH',  last_name:'SAWANT',  birthdate:'29/07/1992', country:'INDIA', nationality:'INDIAN', document_id_number:'ABCD123', document_id_file_path:'10/i/4ae058629d4b384edcda8decdfbf0dd1', selfie_file_path:'10/i/4ae058629d4b384edcda8decdfbf0dd2', ethereum_address:'0x04d39e0b112c20917868ffd5c42372ecc5df577b',estimated_participation_amount:'1.2',residence_proof_file_path:'10/i/4ae058629d4b384edcda8decdfbf0dd3',investor_proof_files_path: ['10/i/4ae058629d4b384edcda8decdfbf0da1', '10/i/4ae058629d4b384edcda8decdfbf0da2'], city:'pune',street_address:'hadapsar',postal_code:'411028',state:'maharashtra'}
ost_kyc_users_kyc_object.submit_kyc(params).to_json
```

Send Approve Email to User:

```ruby
params = {user_id: 11550}
ost_kyc_users_kyc_object.email_approve(params).to_json
```

Send Deny Email to User:

```ruby
params = {user_id: 11550}
ost_kyc_users_kyc_object.email_deny(params).to_json
```

Send Report Issue Email to User:

```ruby
params = {user_id: 11550}
ost_kyc_users_kyc_object.email_report_issue(params).to_json
```

Get a list of existing users kyc and other data:

```ruby
ost_kyc_users_kyc_object.list().to_json
```

Get an existing user kyc:

```ruby
ost_kyc_users_kyc_object.get(user_id: '11007').to_json
```

Get an existing Presigned URL via POST call:

```ruby
ost_kyc_users_kyc_object.get_presigned_url_post({files: {selfie: "image/jpeg"}}).to_json
```

Get an existing Presigned URL via PUT call:

```ruby
ost_kyc_users_kyc_object.get_presigned_url_put({files: {selfie: "image/jpeg"}}).to_json
```

### Users Kyc Detail Module

```ruby
ost_kyc_user_kyc_detail_object = ost_kyc_sdk.services.users_kyc_detail
```

Get an user kyc detail:

```ruby
ost_kyc_user_kyc_detail_object.get(user_id: 11007).to_json
```

### Validators Module

```ruby
ost_kyc_validators_object = ost_kyc_sdk.services.validators
```

Verify Ethereum Address:

```ruby
ost_kyc_validators_object.verify_ethereum_address({ethereum_address: '0x7f2ED21D1702057C7d9f163cB7e5458FA2B6B7c4'}).to_json
```

### Request Specs

To obtain request/API specification, pass in `true` for the optional `api_spec` parameter when initializing SDK object:

```ruby
ost_kyc_sdk = OstKycSdkRuby::Saas::Services.new({api_key: <api_key>, api_secret: <api_secret>, api_base_url: <api_base_url>, api_spec: true})
ost_kyc_user_object = ost_kyc_sdk.services.users
```

And then call a method:

```ruby
ost_kyc_user_object.list().to_json
 {:success=>true, :data=>{:request_uri=>"http://kyc.ost.com:8080/api/v2/users", :request_type=>"GET", :request_params=>"request_timestamp=1542027534&signature=7d61d9494040858ff656a8e9361a3b5990ae969a30d123386069e58290f8e465&api_key=28ad8ebb00c8469e1e32156849e94b3f&page_number=1&order=asc&page_size=3"}}
 ```
