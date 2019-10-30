class RoutinesController < ApplicationController
    def index
        render json: Routine.all
    end

    def show
        render json: Routine.find(params[:id])
    end
end
