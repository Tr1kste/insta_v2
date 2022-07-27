# frozen_string_literal: true

class ChangeTypeUserTel < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.change :phone, :bigint
    end
  end
end
