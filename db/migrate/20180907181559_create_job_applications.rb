class CreateJobApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :job_applications do |t|
      t.integer :applicant_id, nil: false
      t.integer :employer_id, nil: false

      t.timestamps
    end
    add_index :job_applications, [:applicant_id, :employer_id], unique: true
  end
end
