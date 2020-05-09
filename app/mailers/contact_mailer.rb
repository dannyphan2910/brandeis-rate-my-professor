class ContactMailer < ApplicationMailer
    def contact_email
        @contact_email = params[:contact_email]

        mail(to: ENV['GMAIL_USERNAME'] + '@gmail.com', subject: "New Contact Request")
    end
end
