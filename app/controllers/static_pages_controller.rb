class StaticPagesController < ApplicationController
  skip_load_and_authorize_resource

  def home
  end

  def about
  end
end
