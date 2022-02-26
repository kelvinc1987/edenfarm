require 'Airtable'
require 'twilio-ruby'

class BaseController < ApplicationController
  def index

    @Client = Airtable::Client.new("keyr6sRq2AAXV9ash")

    @table = @Client.table("appacJ0nJ0C1wijg2","table1")
    
    @records = @table.records
    # (:sort => ["phoneNumber", :asc], :limit => 50)

    
    
    
  end
  def Choice

  end
  
  def twilio_number(number)

    account_sid = "AC4158ba2bf41e0195d9a2603efc32871c" # Your Account SID from www.twilio.com/console
    auth_token = "f15902c9b4d248315c8858d27b548c1a"   # Your Auth Token from www.twilio.com/console

    begin
      @client = Twilio::REST::Client.new account_sid, auth_token
      @message = @client.messages.create(

        # loop through records and find out how to send it, research json
          body: "Hello from Ruby",
          :to => '+1' +number,    # Replace with your phone number
          from: "+12057973744")  # Replace with your Twilio number
        # rescue Twilio::REST::TwilioError => e
        # puts e.message
    
    end

  end

  def send_text

    @Client = Airtable::Client.new("keyr6sRq2AAXV9ash")

    @table = @Client.table("appacJ0nJ0C1wijg2","table1")

    @Phone = @table.records.new(records_params)

    @Phone.twilio_number(@phone.clean_number)
    
    if @records.save
      redirect_to @records
    else
      render :new
    end
  end 

  private 
  def phone_params
    params.require(:phone).permit(:number)
  end

  def clean_number

    number = self.number.scan(/\d+/).join
    number[0] == "1" ? number[0] = '' :number
    number unless number.length != 10
  end

  
end

