require 'sendgrid-ruby'

class TriggerMailer < ApplicationMailer

  def price_trigger_email
    from = SendGrid::Email.new(email: 'akshaythewonder@gmail.com')
    to = SendGrid::Email.new(email: 'jainn.akshay@gmail.com')
    subject = 'price of the coin reaches to specified price'
    content = SendGrid::Content.new(type: 'text/plain', value: 'binance price matched with created price with user')
    mail = SendGrid::Mail.new(from,subject,to,content)

    #TODO
    sg = SendGrid::API.new(api_key: "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")
    response = sg.client.mail._('send').post(request_body: mail.to_json)

  end
  
end