#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra'
require 'haml'
require 'net/ssh'

get '/' do
  @result = "It's just you. CSIL is up."
  
  begin
    Net::SSH.start('csil-linux-ts1.cs.uiuc.edu', '', :timeout => 5) do |ssh|
    end
  rescue Net::SSH::AuthenticationFailed
    @result = "It's just you. CSIL is up."    
  rescue Timeout::Error
    @result = "It's everyone. CSIL is down."
  end

  haml :index
end

__END__
@@ layout
%html
  %head
    %title CSIL down for everyone or just me?
  %style                     
    :plain                       
      .container{clear:both;font-size:3em;margin:auto;}
      body{background-color:#fff;color:#333;font-family:Arial,Verdana,sans-serif;font-size:62.5%;margin:10% 5% 0 5%;text-align:center;}
      .result{color:#0080ff;font-size:2.5em;padding-top:0.5em;}
                       
  %body
    =yield

@@ index
#content
  .container
    Is CSIL down for everyone or just me?                     
  .result= "#{@result}"


