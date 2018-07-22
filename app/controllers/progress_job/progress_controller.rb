#
#   progress_job/progress_controller.rb
#

module ProgressJob
  class ProgressController < ActionController::Base
    def show
      @delayed_job = Delayed::Job.find_by_id(params[:job_id])
      if @delayed_job.nil? then
        render json: { percentage: 100, complete: true } and return
      end
      percentage = !@delayed_job.progress_max.zero? ?
        @delayed_job.progress_current / @delayed_job.progress_max.to_f * 100 : 0
      render json:
        @delayed_job.attributes
        .merge!(percentage: percentage)
        .to_json
    end
  end
end

#[EOF]
