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

      def event_participations
        event = Event.find_by(id: event_participation_params)
        # event_idのparamsが不正な場合は400を返却する
        raise ActiveRecord::RecordInvalid if !event_participation_params || event.nil?
    
        event.cart_items.create!(menu_id: cart_item_params)
      end

      private

      def set_event
        event = Event.find(params[:id])
        event.admin_id == current_api_v1_admin.id
      end

      def event_params
        params.require(:event).permit(:title, :start_time, :status, :area)
      end

      def event_participation_params
        params.require(:event_id)
      end
    end
  end
end
