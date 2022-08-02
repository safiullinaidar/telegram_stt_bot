module Yandex
  class AsyncStt < Base
    API_URL = "https://transcribe.api.cloud.yandex.net/speech/stt/v2/longRunningRecognize".freeze
    private_constant :API_URL

    def initialize(file_url)
      @file_url = file_url
    end

    def call
      parsed_response["id"]
    end

    private

    attr_reader :file_url

    def parsed_response
      @parsed_response ||= HTTParty.post(API_URL, headers: headers, body: body).parsed_response
    end

    def body
      {
        config: { 
          specification: {
            languageCode: "auto"
          }
        },
        audio: {
          uri: file_url
        }
      }.to_json
    end

    def headers
      {
        "Content-Type" => "application/json"
      }.merge(auth_header)
    end
  end
end
