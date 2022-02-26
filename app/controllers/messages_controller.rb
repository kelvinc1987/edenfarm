require 'Airtable'
require 'twilio-ruby'

class MessagesController < ApplicationController 
  skip_before_action :verify_authenticity_token
 #skip_before_action :authenticate_user!, :only => "reply"


  def reply
    message_body = params["Body"]
    from_number = params["From"]
    boot_twilio
    sms = @client.messages.create(
      from: '+12057973744',
      to: from_number,
      body: "Hello there, thanks for texting me. Your number is #{from_number}."
    
    )
  end




  
  def display
    boot_twilio

    bootAirtable

    @table = @Client.table("appacJ0nJ0C1wijg2","table3")
    
    allMessages = @client.messages.list(limit: 20)

    allMessages.each do |record|
      @newRecord = Airtable::Record.new(:Body => record.body, :To => record.to, :From => record.from)
      @table.create(@newRecord)

      # puts " "
      # puts "Body:"
      # puts record.body
      # puts "To:"
      # puts record.to
      # puts "From:"
      # puts record.from
      
    end

    def sendMessage

      boot_twilio                                                #Boots twilio, calls twilio function to create a new message, passing the message body params, reciever phone params, and sender phone params....
      @message = @client.messages.create(                        #...and sends the message...
        :body => (body_params),
          
        :to => '+1' + (phone_params),   
            
        from: @twilio_number  
      )  
      
      redirect_to :bases
        
    end
    

  end

  
  def body_params                                                   #Passes message body :text from form as a parameter
    params.require(:text)
  end

  def phone_params                                                  #Passes phone number :number from form as param
    params.require(:number)
  end
  
  def convoMessage

    boot_twilio                                                #Boots twilio, calls twilio function to create a new message, passing the message body params, reciever phone params, and sender phone params....
    @message = @client.messages.create(                        #...and sends the message...
      :body => (body_params),
        
      :to => '+1' + (phone_params),   
          
      from: '+12057973744'
    )
    redirect_to :messages
      
  end

  def convo           #Conversation Method

    @keyparams = params.require(:key)
    @valueparams = params.require(:value)
    #catching the key and value parameters passed by inbox, storing as global variables to be used by the convo view

  end

  def inbox

    boot_twilio
    @allMessages = @client.messages.list 

    @phoneHash = {}

    @allMessages.each do |record|
      # if record.to or record.from includes specific number then 
      #   need date/time to and from
      #   calls = @client.calls.list(status: 'busy', to: '+15558675310', limit: 20)      
      if record.from != "+12057973744"

        if @phoneHash.length == 0 

          key = record.from
          val = record.body
          convoArray = []
          convoArray << val
          @phoneHash.store(key,convoArray)
          

        elsif @phoneHash.include? record.from

          key = record.from
          val = record.body
          @phoneHash[key] << val

        else

          key = record.from
          val = record.body
          convoArray = []
          @phoneHash.store(key,convoArray)
          convoArray << val

        end

      end

    end


    
  end

  private
 
  def boot_twilio
    account_sid ='AC4158ba2bf41e0195d9a2603efc32871c'
    auth_token = 'e67e95b9a784fbc334fac87c9534941b'
    twilio_number = '+12057973744'
    @client = Twilio::REST::Client.new account_sid, auth_token
  end

  def bootAirtable
    @Client = Airtable::Client.new("keyr6sRq2AAXV9ash")
  end
end