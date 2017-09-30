module API::V1
  class CandidatesController < ApplicationController

    def update
      @current_user.profile.update_attributes(candidate_params)
      render json: @current_user.profile, status: :ok
    rescue StandardError => ex
      logger.debug("CandidatesController#update Error: {ex}")
      render json: { error: 'Something went wrong. Please try again later' }, status: :internal_server_error
    end

    private

    def candidate_params
      params.require(:candidate).permit(:address, :city, :state, :zip, :title, :description, :minimum_salary,
                                        :linkedin, :github, :is_active, :can_relocate, :can_remote, :is_visa_needed, :specialization_id, :company_size_id, :job_type_id)
    end
  end
end
