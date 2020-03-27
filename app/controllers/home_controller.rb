class HomeController < ApplicationController
    
    def render_home
        @professor = Professor.new(params[:user])
        @course = Course.new(params[:address])
        render 'home/index'
    end
end
