module SessionsHelper
    # Logs in the given user.
    def log_in(user)
        session[:user_id] = user.id
    end

    # Returns the current logged-in user (if any).
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end

    # Returns true if the user is logged in, false otherwise.
    def logged_in?
        !current_user.nil?
    end

    # Logs out the current user.
    def log_out
        session.delete(:user_id)
        @current_user = nil
    end

    # Returns most reviewed courses
    def get_courses_most_reviewed num
        ids = Course.joins(:reviews).group(:id).count(:all).sort_by {|k,v| v}.reverse.first(num).to_h.keys
        courses = Course.where(id: ids)
        return get_hash_result courses, true
    end
    
    # Returns most reviewed professors
    def get_professors_most_reviewed num
        ids = Professor.joins(:reviews).group(:id).count(:all).sort_by {|k,v| v}.reverse.first(num).to_h.keys
        professors = Professor.where(id: ids)
        return get_hash_result professors, false
    end
end
