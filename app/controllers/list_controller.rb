class ListController < ApplicationController
  def list
    @Properties = Property.all
  end
end
