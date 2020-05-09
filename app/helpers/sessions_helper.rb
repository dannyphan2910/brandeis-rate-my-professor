module SessionsHelper
    # Logs in the given user.
    def log_in(user)
        session[:user_id] = user.id
    end

    # Returns the current logged-in user (if any).
    # def current_user
    #     current_user ||= User.find_by(id: session[:user_id])
    # end

    # Returns true if the user is logged in, false otherwise.
    def logged_in?
        user_signed_in? || !current_user.nil?
    end

    # Logs out the current user.
    def log_out
        session.delete(:user_id)
        @current_user = nil
    end

    def get_hash data
        arr = data["prof_first_name"] ? get_labels(false) : get_labels(true)
        res = {}
        (1..5).each do |num|
            res["avg_cat" + num.to_s] = arr[num-1]
        end
        res
    end

    def get_labels forCourse
        forCourse ? ["Content", "Participation", "Workload", "Testing", "Grading"] : ["Delivery", "Accessibility", "Expertise", "Expectations", "Preparedness"] 
    end

    def icon_for score
        if score == "N/A"
            return content_tag :i, '', class: 'far fa-question-circle fa-2x'
        end
        score = score.to_f * 100
        icon = case score
            when 0..133 then content_tag :i, '', class: 'far fa-frown fa-2x'
            when 134..332 then content_tag :i, '', class: 'far fa-meh fa-2x'
            when 333..449 then content_tag :i, '', class: 'far fa-smile-beam fa-2x'
            when 450..500 then content_tag :i, '', class: 'far fa-grin-stars fa-2x'
        end
        icon
    end
end
