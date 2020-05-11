RailsAdmin.config do |config|

  config.authorize_with do
    redirect_to main_app.root_path unless current_user.is_admin_user == true
  end

  config.model 'User' do
    
  end

  config.model 'Professor' do
    object_label_method do
      :show_name
    end
  end

  config.model 'GeneralCourse' do
    object_label_method do
      :course_code
    end
  end

  config.model 'Course' do
    object_label_method do
      :admin_course_label
    end
    list do 
      field :professor
      field :semester
      field :year
      field :general_course
      field :created_at
      field :updated_at
    end
  end

  config.model 'Review' do
    list do
      field :user_id
      field :created_at
      field :updated_at
      field :course
      field :professor
      field :course_review
      field :professor_review
    end
    show do
      field :user_id
      field :created_at
      field :updated_at
      field :course
      field :professor
      field :course_review
      field :professor_review
    end
  end

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true
  config.included_models = ['User', 'Professor', 'Course', 'GeneralCourse', 'Review']
  config.actions do
    # root actions
    dashboard
    #collection actions
    index
    new
    export
    bulk_delete
    show
    edit do
      except 'Review'
    end
    delete
    import
    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
