class TopController < ApplicationController
  def index
    render :layout => nil
    #render :layout => "second_layout"
  end
end
