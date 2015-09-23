class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@#{ ENV['APP_HOST'] }"
  layout false
end
