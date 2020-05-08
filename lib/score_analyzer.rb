module ScoreAnalyzer
    class ReviewScore
    end

    class MatchScore
        def initialize general_course, 
            
            
        end

        def match_score real_participation, base_participation, real_workload, base_workload, real_grading, base_grading
            100 - ((real_participation - base_participation).abs + (real_workload - base_workload).abs + (real_grading - base_grading).abs) * 100 / 12.0
        end
    end
end