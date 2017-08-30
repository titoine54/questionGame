class WelcomeController < ApplicationController
  def index
  end

  def about
    @controller_message = 'test'
  end
end
