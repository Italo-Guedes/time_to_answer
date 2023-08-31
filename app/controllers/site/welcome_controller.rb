class Site::WelcomeController < SiteController
  def index
    @questions = Question.las_questions(params[:page])
  end
end


