module GeneralCoursesHelper
    def match_score general_course, likes_participation, likes_workload, likes_grading
        gc_stat = general_course.get_average
        real_participation = gc_stat['avg_cat2']
        real_workload = (gc_stat['avg_cat3'] + gc_stat['avg_cat4']) / 2.0
        real_grading = gc_stat['avg_cat4']

        base_participation = likes_participation ? 1 : 5
        base_workload = likes_workload ? 1 : 5
        base_grading = likes_grading ? 1 : 5

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
