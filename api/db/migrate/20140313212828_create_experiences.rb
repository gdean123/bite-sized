class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.string :tagline

      t.timestamps
    end
  end
end
