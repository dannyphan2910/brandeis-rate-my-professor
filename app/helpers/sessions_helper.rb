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
    
    # forCourses = true: courses, forCourses = false: professors
    def get_hash_result records, forCourses
        result = []
        records.each do |record|
          record_hash = add_avg record.as_json, forCourses ? record.course_ratings : record.professor_ratings
          result.push(record_hash)
        end
        return result
    end
    
    # Calculates the average of each category for every rating
    def add_avg record_hash, ratings
        record_hash['avg_cat1'] = ratings.average(:cat1).round(2)
        record_hash['avg_cat2'] = ratings.average(:cat2).round(2)
        record_hash['avg_cat3'] = ratings.average(:cat3).round(2)
        record_hash['avg_cat4'] = ratings.average(:cat4).round(2)
        record_hash['avg_cat5'] = ratings.average(:cat5).round(2)
        record_hash['total_reviews'] = ratings.length
        return record_hash
    end
end
