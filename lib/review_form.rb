require File.expand_path('../../config/environment',  __FILE__)

class ReviewForm
    def initialize current_user
        @current_user = current_user
    end

    def filter_user_reviewed_courses
        user_reviews = @current_user.reviews
        reviewed = []
        user_reviews.each do |ur|
            cid = ur.course_id
            curr_course = Course.find(cid)
            gcid = curr_course.general_course_id;
            y = curr_course.year
            s = curr_course.semester
            same_name_ys = Course.where(general_course_id: gcid, year: y, semester: s)
            if !reviewed.include?(cid)
              same_name_ys.each do |c|
                reviewed.push(c.id)
              end
            end
        end
        return reviewed
    end

    def filter_professor_by_course_helper ys, course_code
        y = ys.split(" ")[0]
        s = ys.split(" ")[1]
        gcid = GeneralCourse.find_by(course_code: course_code)
        course = Course.where(general_course_id: gcid, year: y, semester: s)
        @filtered_professor = []
        course.each do |c|
          @filtered_professor.push(c.professor)
        end
        @filtered_professor.sort
    end

    def filter_course_by_year_helper ys
        y = ys.split(" ")[0]
        s = ys.split(" ")[1]
        filter = Course.where(year:y,semester:s)
        user_reviewed_courses = filter_user_reviewed_courses
        used = []
        @filtered_course = []
        filter.each do |f|
          cid = f.id
          gcid = f.general_course_id
          if !used.include?(gcid) && !user_reviewed_courses.include?(cid)
            @filtered_course.push(GeneralCourse.find(gcid).show_course_info)
            used.push(gcid)
          end
        end
        @filtered_course = @filtered_course.sort do |a,b|
          if a.split(" ")[0] > b.split(" ")[0]
            1
          elsif a.split(" ")[0] < b.split(" ")[0]
            -1
          else
            if only_number(a.split(" ")[1]) > only_number(b.split(" ")[1])
              1
            else
              -1
            end
          end
        end
        return @filtered_course.insert(0,"Select A Course") 
    end
  
    def same_name_course(gcid,yr,smstr)
        ids = []
        courses = Course.where(general_course_id:gcid, year: yr, semester: smstr)
        courses.each do |c|
          ids.push(c.id)
        end
        return ids
    end

    def only_number(num_ab)
        return num_ab[0...-1].to_i
    end
end