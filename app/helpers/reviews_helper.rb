module ReviewsHelper
    def all_years
        years = []
        Course.all.each do |c|
            year_sem = "" + c.year.to_s + "," + c.semester.to_s
            if !years.include?(year_sem)
                years.push(year_sem)
            end
        end
        return years.sort.reverse
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
