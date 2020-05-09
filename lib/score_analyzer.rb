require File.expand_path('../../config/environment',  __FILE__)

module ScoreAnalyzer
    class ReviewScore
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
                average = record.get_average
                record_hash = record.as_json
                if forCourses
                    record_hash['course_code'] = record.course_code
                    record_hash['course_title'] = record.course_title
                    record_hash['course_description'] = record.course_description
                elsif record.department
                    record_hash['dept_name'] = record.department.dept_name
                end
                record_hash.merge! average
                result.push(record_hash)
            end
            return result
        end
    
        def get_dept_result records
            result = []
            records.each do |record|
                average = record.get_info
                record_hash = record.as_json
                record_hash.merge! average
                result.push(record_hash)
            end
            return result
        end
    end

    class MatchScore
        def initialize gc, likes_participation, likes_workload, likes_testing
            @base_participation = likes_participation ? 1 : 5
            @base_workload = likes_workload ? 1 : 5
            @base_testing = likes_testing ? 1 : 5

            gc_stat = gc.get_average
            @real_participation = gc_stat['avg_cat2']
            @real_workload = (gc_stat['avg_cat3'] + gc_stat['avg_cat4']) / 2.0
            @real_testing = gc_stat['avg_cat4']
        end

        def match_score     
            @score = 100 - ((@real_participation - @base_participation).abs + (@real_workload - @base_workload).abs + (@real_testing - @base_testing).abs) * 100 / 12.0
            @score
        end

        def analyze_score 
            if @score >= 80 
                return 'IT\'S A MATCH'
            elsif @score < 50
                return 'NOT A MATCH'
            else 
                return 'MAYBE?'
            end
        end
    end
end