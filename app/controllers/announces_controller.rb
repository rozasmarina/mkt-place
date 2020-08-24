class AnnouncesController < ApplicationController

  def index
    @announces = Announce.all
  end
end
