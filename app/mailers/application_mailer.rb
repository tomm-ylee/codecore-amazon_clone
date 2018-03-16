class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@amazon.com'
  layout 'mailer'
end
