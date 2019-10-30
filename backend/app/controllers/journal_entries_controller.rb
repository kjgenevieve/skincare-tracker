class JournalEntriesController < ApplicationController
    def index
        render json: JournalEntry.all
    end

    def show
        render json: JournalEntry.find(params[:id])
    end
end
