module ReviewsHelper
    def all_years
        years = []
        Course.all.each do |c|
            year_sem = "" + c.year.to_s + " " +  c.semester.to_s
            if !years.include?(year_sem)
                years.push(year_sem)
            end
        end
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
        courses = []
        GeneralCourse.all.each do |gc|
            if !courses.include?(gc.show_course_info)
                courses.push(gc.show_course_info)
            end
        end
        return courses
    end
end
