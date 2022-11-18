class IndexController < ApplicationController
  def index
    #@Properties = Property.all
    @q = Property.ransack(params[:q])
    @properties = @q.result(distinct:true)

  end
end

