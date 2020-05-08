module GeneralCoursesHelper
    def match_score real_participation, base_participation, real_workload, base_workload, real_grading, base_grading
        puts real_participation, base_participation, real_workload, base_workload, real_grading, base_grading
        100 - ((real_participation - base_participation).abs + (real_workload - base_workload).abs + (real_grading - base_grading).abs) * 100 / 12.0
    end

    def analyze_score score
        if score >= 80 
            return 'IT\'S A MATCH'
        elsif score < 50
            return 'NOT A MATCH'
        else 
            return 'MAYBE?'
        end
    end

    def match_icon_for indicator
        case indicator
            when 'IT\'S A MATCH' then content_tag(:i, '', class: 'fas fa-heart fa-5x text-success')
            when 'NOT A MATCH' then content_tag(:i, '', class: 'fas fa-heart-broken fa-5x text-danger')
            when 'MAYBE?' then content_tag(:i, '', class: 'fas fa-question fa-5x text-secondary')
        end
    end

    def is_likely indicator
        indicator == 'IT\'S A MATCH'
    end

    def is_unlikely indicator
        indicator == 'NOT A MATCH'
    end

    def is_maybe indicator
        indicator == 'MAYBE?'
    end
end
