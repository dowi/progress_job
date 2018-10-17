#
#   progress_job/progress_controller.rb
#

module ProgressJob
  class ProgressController < ActionController::Base
    def show
      @delayed_job = \
        Delayed::Job.find_by_id(params[:job_id])

      if @delayed_job.nil? then
        render json: {
          percentage: 100,
          complete:   true
        }
      else
        percentage = \
          @delayed_job.progress_max.zero? ? 0 : \
          @delayed_job.progress_current \
          .fdiv(@delayed_job.progress_max) * 100

        render json: \
          @delayed_job.attributes \
          .symbolize_keys \
          .except(:handler, :last_error) \
          .merge(percentage: percentage)
      end
    end
  end
end

#[EOF]
