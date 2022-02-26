# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

<!--



            MATEOS MYSTERY CODE



            <%# <%=@records1%>
            <%# <h1> Phone Numbers </h1> %>

            <% @numbers = []%>

            <% @records1.each do |number|%>
                <% @numbers << number.phone_number%>
            <% end %>

            <% @x = [] %>

            <% @numbers.each do |number|%>
                <% @x <<  ' {"binding_type":"sms", "address":"+1 %s "},  '% number %>
            <%end%>

            <% @date = []%>
            <% @number_date = []%>

            <% @y = [] %>

            <% @number_date.each do |number|%>
                <% @y <<  ' {"binding_type":"sms", "address":"+1 %s "},  '% number %>
            <%end%>

            <% = @x %>

            <% <h1> Specific Date </h1> %>

            

            <% = @date %>

            <% <h1> Phone Numbers By That Specific Date </h1> %>
            <% = @number_date %>


            

            <% <h1> Phone numbers ready for to_binding: </h1> %>

            <% = @y %>

-->
# edenfarm
