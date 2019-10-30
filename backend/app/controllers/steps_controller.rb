class StepsController < ApplicationController
    def index
        render json: Step.all
    end

    def show
        render json: Step.find(params[:id])
    end
end
