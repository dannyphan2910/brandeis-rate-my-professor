# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview
    def contact_email   
        contact_email = { 
            name: 'Testing Name',
            email: 'testing@gmail.com',
            message: 'Sample Messsage<br><b>testing!!!</b>',
            timestamp: Time.now
        }

        ContactMailer.with(contact_email: contact_email).contact_email
    end
end
