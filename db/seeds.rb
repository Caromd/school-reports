# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@levels = Level.all
@subjects = Subject.all
@user_id = 1

@levels.each do |level|
    if level.name == "11" or level.name == "12"
        @mark1_percentage = 25
        @mark2_percentage = 75
    else
        @mark1_percentage = 75
        @mark2_percentage = 25       
    end
    @subjects.each do |subject|
        Markpercent.create(level_id: level.id, subject_id: subject.id, user_id: @user_id, mark1_label: "Class", mark1_percentage: @mark1_percentage, mark2_label: "Tests", mark2_percentage: @mark2_percentage)
    end
end