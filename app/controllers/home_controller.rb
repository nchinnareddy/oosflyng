class HomeController < ApplicationController

  def say_hi

    name = params[:name]
    render :json => {:status => "ok", :msg => "Hello #{name}"}
  end
end
