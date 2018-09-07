class JobApplicationsController < ApplicationController
  def create
    job_application = JobApplication.new(job_application_params)
    job_application.applicant_id = current_user.id
    if job_application.save
      flash[:notice] = "Successfully applied to #{job_application.employer.name}"
    else
      flash[:notice] = "Error"
    end
    redirect_to root_path
  end

  private

  def job_application_params
    params.require(:job_application).permit(:employer_id)
  end
end
