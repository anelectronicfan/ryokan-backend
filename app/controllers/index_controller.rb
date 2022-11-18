class IndexController < ApplicationController
  def index
    @Properties = Property.all
  end
end
