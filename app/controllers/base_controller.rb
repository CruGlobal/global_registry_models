## Base Controller to enforce authentification
class BaseController < ApplicationController
  before_action :authenticate_user
end
