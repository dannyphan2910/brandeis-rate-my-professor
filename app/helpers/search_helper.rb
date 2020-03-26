module SearchHelper
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
        record_hash['avg_cat1'] = ratings.average(:cat1) || 0
        record_hash['avg_cat2'] = ratings.average(:cat2) || 0
        record_hash['avg_cat3'] = ratings.average(:cat3) || 0
        record_hash['avg_cat4'] = ratings.average(:cat4) || 0
        record_hash['avg_cat5'] = ratings.average(:cat5) || 0
        record_hash['total_reviews'] = ratings.length
        return record_hash
    end
end
