class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :update]

  # TODO find a way to make this safer
  protect_from_forgery with: :null_session, only: [:vote, :game]

  # GET /questions
  # GET /questions.json
  def index

  end

  # GET /questions/list
  def list
    @questions = Question.all.order(score: :desc)
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # POST /questions/vote/:id
  def vote
    @question = Question.find(params[:id])

    if params[:vote_type] == "UP"
      @question.increment(:ups, 1)
    elsif params[:vote_type] == "DOWN"
      @question.increment(:downs, 1)
    else
      return
    end

    epoch_question_creation = @question.created_at.to_datetime().to_i

    seconds = epoch_question_creation - 1525046400 # website creation on Monday, 30 April 2018 00:00:00 (GMT)
    diff = @question.ups - @question.downs

    order = Math.log10([diff.abs, 1].max)

    if diff > 0
      sign = 1
    elsif diff < 0
      sign = -1
    else
      sign = 0
    end

    score = (sign * order + seconds / 45000).round(7)

    @question.update(score: score)
    @question.save()

    redirect_to controller: "questions", action: "game", question_id: @question.id

  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/game
  def game
    if params[:question_id].present?
      if Question.count == session[:old_questions_id].count + 1
        session[:old_questions_id] = []
        redirect_to action: "index"
      else
        unless session[:old_questions_id].include? params[:question_id].to_i
          session[:old_questions_id].push(params[:question_id].to_i)
        end
        @question = Question.where.not(id: session[:old_questions_id]).order("score DESC").first
      end
    else
      @question = Question.order("score DESC").first
      session[:old_questions_id] = []
    end
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:question, :author, :country, :state)
    end
end
