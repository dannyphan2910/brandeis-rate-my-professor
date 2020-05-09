class ContactController < ApplicationController
  def index
  end

  def email
    if params[:name] && params[:email] && params[:message]
      @contact_email = {
        name: params[:name],
        email: params[:email],
        message: params[:message],
        timestamp: Time.now
      }
      
      ContactMailer.with(contact_email: @contact_email).contact_email.deliver_now
      redirect_to root_path, notice: 'Thank you for your message! We will try to respond to you as soon as possible.'
    else
      redirect_to '/contact', alert: 'An error has occured. Please re-fill the contact form.'  
    end
  end
end
