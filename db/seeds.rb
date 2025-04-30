puts "Creating 100 projects with tasks..."

ActiveRecord::Base.transaction do
  100.times do |i|
    project = Project.create!(name: "Project #{i + 1}")

    30.times do |j|
      parent_task = j > 0 && rand < 0.2 ? project.tasks.sample : nil
      expires_at = rand < 0.7 ? rand(1..5).months.from_now : rand(1..2).months.ago

      project.tasks.create!(
        name: "Task #{j + 1} for Project #{i + 1}",
        expires_at: expires_at,
        parent: parent_task
      )
    end
  end
end

puts "Seed data created successfully!"
