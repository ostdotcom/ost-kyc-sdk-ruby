class Config

  API_BASE_URL = ENV['OST_KYC_API_ENDPOINT']
  API_KEY = ENV['OST_KYC_API_KEY']
  API_SECRET = ENV['OST_KYC_API_SECRET']
  OST_SDK = OstKycSdkRuby::Saas::Services.new({api_key: API_KEY, api_secret: API_SECRET, api_base_url: API_BASE_URL})

end