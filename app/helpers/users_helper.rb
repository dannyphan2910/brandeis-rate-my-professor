module UsersHelper

    def avatar_for(user)
        if user.avatar.attached? 
            image_tag(user.avatar, alt: 'profile picture', width: '100', height: '100', class: 'rounded-circle image', style: 'object-fit: cover;')
        else
            gravatar_for(user)
        end
    end

    # Returns the Gravatar for the given user.
    def gravatar_for(user)
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
        image_tag(gravatar_url, alt: 'profile picture', class: 'gravatar rounded-circle image', width: '100', height: '100', style: 'object-fit: cover;')
    end
end
