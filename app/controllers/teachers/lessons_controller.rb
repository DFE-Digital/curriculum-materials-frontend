module Teachers
  class LessonsController < BaseController
    before_action :load_resources, only: %i[show print]

    def show; end

    def print
      render layout: 'print'
    end

  private

    def load_resources
      @lesson = Lesson.eager_load(lesson_parts: :default_activity).find(params[:id])

      @presenter = Teachers::LessonContentsPresenter.new(@lesson, current_teacher)
    end
  end
end
