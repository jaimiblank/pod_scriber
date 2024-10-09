class CreatePodcasts < ActiveRecord::Migration[7.1]
  def change
    create_table :podcasts do |t|
      t.string :audio_file
      t.text :transcript

      t.timestamps
    end
  end
end
