gender = ["male", "female"]
ccsd_no = 3333333

1.times do 

  200.times do 
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    student = Student.create!(
      :gender => gender.sample,
      :birthday => "1985-05-05",
      :ccsd_id => ccsd_no += 1,
      :grade_level => 7,
      :email => Faker::Internet.email)

    student.build_identity(
      :password => 'password',
      :first_name => first_name,
      :last_name => last_name,
      :username => "#{first_name}#{last_name}")
    student.save
    p "Student Created: #{student.username}  #{student.ccsd_id}" 
  end

  200.times do 
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    guardian = Guardian.create!(preferred_language: "English")

    guardian.build_identity(
      :password => 'password',
      :first_name => first_name,
      :last_name => last_name,
      :guardian_id => guardian.id,
      :username => "#{first_name}#{last_name}")
    guardian.save
    p "Guardian Created: #{guardian.username}" 
  end

  200.times do |i|
    guardianship = Guardianship.create!(
      :student_id => i + 1,
      :guardian_id => i + 1,
      :relationship_to_student => 'Parent')
    p "guardianship created"
  end
end

subjects = ["Reading", "Math", "US History", "Science", "Geography", "Writing"]
subjects.each do |subject| 
  7.times do |i|
    Subject.create!(:name => "#{subject} 10#{i}")
    p "created Subject #{subject} 10#{i}"
  end
end

10.times do 
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  teacher = Teacher.create!(
    :title => Faker::Lorem.words(num = 1),
    :email => Faker::Internet.email)

  teacher.build_identity(
    :password => 'password',
    :first_name => first_name,
    :last_name => last_name,
    :username => "#{first_name}#{last_name}",
    :teacher_id => teacher.id)
  teacher.save
  p "Teacher Created: #{teacher.username}" 

  7.times do |i|
    course = Course.new(
      teacher_id: teacher.id,
      period: i + 1,
      subject_id: Subject.all.sample.id)
      until course.valid?
        course.subject_id = Subject.all.sample
      end
      course.save
    p "Course Created period #{course.period}"
  end
end

6.times do
  students = Student.all
  students.each do |student|
    enrollment = Enrollment.new(
      :student_id => student.id,
      :course_id => Course.all.sample.id)
      until enrollment.valid?
        enrollment.course = Course.all.sample
      end
      enrollment.save
    p "Enrollment created for #{student.first_name}"
  end
end
