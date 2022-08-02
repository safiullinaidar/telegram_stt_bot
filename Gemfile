source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.0"

gem "rails", "~> 7.0.3"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "resque"
gem "redis", "<4"
gem "dotenv-rails"
gem "httparty"

gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem "pry-rails"
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end
