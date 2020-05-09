module ReviewsHelper
    def all_years
        years = Course.pluck(:semester, :year).uniq.map { |sem| sem[1].to_s + " " + sem[0] }
        years = years.sort do |a,b|
            if a.split(" ")[0] > b.split(" ")[0]
                -1
            elsif a.split(" ")[0] < b.split(" ")[0]
                1
            else
                if a.split(" ")[1] > b.split(" ")[1]
                    1
                else
                    -1
                end
            end
        end
        return years
    end

    def all_courses
        courses = GeneralCourse.all.map { |gc| gc.show_course_info }
        return courses
    end
end
