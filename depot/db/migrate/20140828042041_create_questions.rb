class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :name
      t.string :mail_id
      t.string :ques

      t.timestamps
    end
  end
end