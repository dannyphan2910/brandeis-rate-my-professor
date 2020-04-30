module SearchHelper
    # forCourses = true: courses, forCourses = false: professors
    def get_hash_result records, forCourses
        result = []
        records.each do |record|
            average = record.get_average
            record_hash = record.as_json
            if forCourses
                record_hash['course_code'] = record.course_code
                record_hash['course_title'] = record.course_title
                record_hash['course_description'] = record.course_description
            else
                record_hash['dept_name'] = record.department.dept_name
            end
            record_hash.merge! average
            result.push(record_hash)
        end
        puts result
        return result
    end
end
