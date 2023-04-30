# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.datetime :start_time, null: false
      t.integer :status, null: false, default: 0
      t.string :area, null: false

      t.references :admin, foreign_key: true
      t.timestamps
    end
  end
end
