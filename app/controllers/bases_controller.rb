
require 'Airtable'
require 'twilio-ruby'                   
#require 'sinatra'

class BasesController < ApplicationController


  def boot_twilio                                                   #Initializing Twilio API
    account_sid ='AC4158ba2bf41e0195d9a2603efc32871c'
    auth_token = 'e67e95b9a784fbc334fac87c9534941b'
    @twilio_number = '+12057973744'
    notifyservice = "MG5e52f42fab2d2aa9ca67d071ec61fe8b"            #Lines 12 and 13 Initializes twilio notification service
    @client = Twilio::REST::Client.new account_sid, auth_token
    @service = @client.notify.v1.services("IS4fabc1efe09790f1d1fab101d95aff8b")
  end

  def index                                                        #initializes Airtable

    @Client = Airtable::Client.new("keyr6sRq2AAXV9ash")
    @table = @Client.table("appacJ0nJ0C1wijg2","table1")           #creates a variable named table that represents our table 1 in airtable
    @records1 = @table.records                                     #gets all the information out of table 1 in airtable
    
    @Client2 = Airtable::Client.new("keyr6sRq2AAXV9ash") 
    @table2 = @Client2.table("appacJ0nJ0C1wijg2","table2")
    @records2 = @table2.records(:sort => ["Id", :asc])
    

  end

  def body_params                                                   #Passes message body :text from form as a parameter
    params.require(:text)
  end

  def phone_params                                                  #Passes phone number :number from form as param
    params.require(:number)
  end


  def sendMessage                                                  #main function to send messages through twilio
    index

    if params[:choice] == "Specific Number"                        #If specific number is selected by the user on the form...
      
      begin
        boot_twilio                                                #Boots twilio, calls twilio function to create a new message, passing the message body params, reciever phone params, and sender phone params....
        @message = @client.messages.create(                        #...and sends the message...
          :body => (body_params),
            
          :to => '+1' + (phone_params),   
              
          from: @twilio_number  
        )  
        
        redirect_to :bases                                        #refreshes the page
      end

    elsif params[:choice] == "All Numbers"                        #If all numbers is selected by the user on the form...

      begin
                                                    
                                                            

        @numbers = []                                             #Loops through all records, storing only phone numbers in new array @numbers
          @records1.each do |i|
            @numbers << i.phone_number
          end 
    
        @to = []                                                  #Loops through all elements of @numbers, adds each phone number [i] to the end of string "binding", which will be used to send a notification...
          @numbers.each do |i|                                    #... shovels each "bind" + phone number into new array @to
            @to <<  ' {"binding_type":"sms", "address":"+1 %s "} '% i 
          end
        
        boot_twilio                                               #Boots twilio, creates new notification (like a message, but to more than one reciever), passes array @to as the reciever to_binding: ...      
        notification = @service.notifications.create(             #.. and body_params as message body 
          to_binding: @to,
          body: (body_params)
        )

        redirect_to :bases
      end

    elsif params[:choice] == "By Date"

      begin
       
                                                           
        
        @date1 = params[:date]                                    #Passing the start date and end date (:date, :date2) as params and setting to @date, @date2
        @date2 = params[:date2]

        @number_date = []                                        
        @records1.each do |number|                                #Loop through all records, setting dateAdded = the date each phone number was added from the airtable...
        dateAdded = number.date_added                             #checking if dateAdded is between the start date and end date, if so, shovels the phone number of that record into new array @number_date
          if dateAdded >= @date1 && dateAdded <= @date2
            @number_date << number.phone_number
          end
        end
      
          @to = []                                                #Loops through all elements of @numbers, adds each phone number [i] to the end of string "binding", which will be used to send a notification...
          @number_date.each do |number|                           #... shovels each "bind" + phone number into new array @to
            @to <<  ' {"binding_type":"sms", "address":"+1 %s "} '% number 
          end
          
        boot_twilio                                               #Boots twilio, creates new notification (like a message, but to more than one reciever), passes array @to as the reciever to_binding: ...
          notification = @service.notifications.create(           #.. and body_params as message body
            to_binding: @to,

            body: (body_params)
          ) 
        redirect_to :bases
      end
    end
  end
end

