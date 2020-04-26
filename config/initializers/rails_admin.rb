RailsAdmin.config do |config|


  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

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

  config.model 'Course' do
    object_label_method do
      :admin_course_label
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
  config.included_models = ['User', 'Professor', 'Course']
  config.actions do
    # root actions
    dashboard
    #collection actions
    index
    new
    export
    bulk_delete
    show
    edit
    delete
    import
    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
