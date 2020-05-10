module GeneralCoursesHelper
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
