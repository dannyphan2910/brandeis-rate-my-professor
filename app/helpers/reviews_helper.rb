module ReviewsHelper
    def all_years
        years = []
        Course.all.each do |c|
            if !years.include?(c.year)
                years.push(c.year)
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
