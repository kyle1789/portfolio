class HomeController < ApplicationController
  def index
    @experiences = Experience.ordered.with_attached_screenshots
    @projects = Project.ordered.with_attached_screenshots
  end
end
