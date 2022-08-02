module Yandex
  class Base < ApplicationService
    private

    def auth_header
      {
        Authorization: "Api-Key #{YANDEX_API_KEY}"
      }
    end
  end
end
