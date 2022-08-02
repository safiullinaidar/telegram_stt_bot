module Yandex
  class SyncStt < Base
    API_URL = "https://stt.api.cloud.yandex.net/speech/v1/stt:recognize".freeze
    private_constant :API_URL

    def initialize(file_path)
      @file_path = file_path
    end

    def call
      parsed_response["result"]
    end

    private

    attr_reader :file_path

    def parsed_response
      @parsed_response ||= HTTParty.post(API_URL, query: query, headers: headers, body: body)
    end

    def query
      {
        lang: "auto",
        topic: "general"
      }
    end

    def headers
      {
        "Content-Type" => "audio/ogg"
      }.merge(auth_header)
    end

    def body
      @body ||= File.new(file_path, "rb").read
    end
  end
end
