# frozen_string_literal: true

module Api
  module V1
    class EventsController < ApplicationController

      before_action :set_events, only: [:show, :update]
      def index
        events = Event.where(admin_id: 1)

        render json: events
      end

      def show
        render json: event
      end

      def create
        event = Event.new(event_params)
        event.admin_id = current_api_v1_admin.id
        if event.save
          render json: { status: :ok, data: event }
        else
          render json: { status: :bad_request, data: errors }
        end
      end

      def update
        if event.update(event_params)
          render json: { status: :ok, data: event }
        else
          render json: { status: :bad_request, data: errors }
        end
      end

      private

      def set_event
        event = Event.find(params[:id])
        event.admin_id == current_api_v1_admin.id
      end

      def event_params
        params.require(:event).permit(:title, :start_time, :status, :area)
      end
    end
  end
end
